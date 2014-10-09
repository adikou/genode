/*
 * \brief   Round-robin scheduler
 * \author  Martin Stein
 * \date    2012-11-30
 */

/*
 * Copyright (C) 2012-2013 Genode Labs GmbH
 *
 * This file is part of the Genode OS framework, which is distributed
 * under the terms of the GNU General Public License version 2.
 */

#ifndef _KERNEL__SCHEDULER_H_
#define _KERNEL__SCHEDULER_H_

/* core includes */
#include <kernel/configuration.h>
#include <kernel/double_list.h>
#include <assert.h>

namespace Kernel
{
	/**
	 * Range save priority value
	 */
	class Priority;

	/**
	 * Inheritable ability for objects of type T to be item in a scheduler
	 */
	template <typename T>
	class Scheduler_item;

	/**
	 * Round robin scheduler for objects of type T
	 */
	template <typename T>
	class Scheduler;
}

class Kernel::Priority
{
	private:

		unsigned _value;

	public:

		enum {
			MIN = 0,
			MAX = MAX_PRIORITY,
		};

		/**
		 * Constructor
		 */
		Priority(unsigned const priority)
		:
			_value(Genode::min(priority, MAX))
		{ }

		/**
		 * Assignment operator
		 */
		Priority & operator =(unsigned const priority)
		{
			_value = Genode::min(priority, MAX);
			return *this;
		}

		operator unsigned() const { return _value; }
};

/**
 * Ability to be item in a scheduler through inheritance
 */
template <typename T>
class Kernel::Scheduler_item : public Double_list_item
{
	private:

		Priority const _priority;

	protected:

		/**
		 * Return wether this item is managed by a scheduler currently
		 */
		bool _scheduled() const { return Double_list_item::_listed(); }

	public:

		/**
		 * Constructor
		 *
		 * \param p  scheduling priority
		 */
		Scheduler_item(Priority const p) : _priority(p) { }


		/***************
		 ** Accessors **
		 ***************/

		Priority priority() const { return _priority; }
};

template <typename T>
class Kernel::Scheduler
{
	private:

		T * const            _idle;
		T *                  _occupant;
		Double_list_typed<T> _items[Priority::MAX + 1];
		bool                 _yield;

		bool _does_update(T * const occupant)
		{
			if (_yield) {
				_yield = false;
				return true;
			}
			if (_occupant != occupant) { return true; }
			return false;
		}

	public:

		typedef Scheduler_item<T> Item;

		/**
		 * Constructor
		 */
		Scheduler(T * const idle) : _idle(idle), _occupant(0) { }

		/**
		 * Adjust occupant reference to the current scheduling plan
		 *
		 * \param updated    true on return if the occupant has changed/yielded
		 * \param refreshed  true on return if the occupant got a new timeslice
		 *
		 * \return  updated occupant
		 */
		T * update_occupant(bool & updated, bool & refreshed)
		{
			for (int i = Priority::MAX; i >= 0 ; i--) {
				T * const new_occupant = _items[i].head();
				if (!new_occupant) { continue; }
				updated                = _does_update(new_occupant);
				T * const old_occupant = _occupant;
				if (!old_occupant) { refreshed = true; }
				else {
					unsigned const new_prio = new_occupant->priority();
					unsigned const old_prio = old_occupant->priority();
					refreshed               = new_prio <= old_prio;
				}
				_occupant = new_occupant;
				return new_occupant;
			}
			updated   = _does_update(_idle);
			refreshed = true;
			_occupant = 0;
			return _idle;
		}

		/**
		 * Adjust scheduling plan to the fact that the current occupant yileds
		 */
		void yield_occupation()
		{
			_yield = true;
			if (!_occupant) { return; }
			_items[_occupant->priority()].head_to_tail();
		}

		/**
		 * Include 'i' in scheduling
		 */
		void insert(T * const i)
		{
			assert(i != _idle);
			_items[i->priority()].insert_tail(i);
		}

		/**
		 * Include item in scheduling and check wether an update is needed
		 *
		 * \param item  targeted item
		 *
		 * \return  wether the current occupant is out-dated after insertion
		 */
		bool insert_and_check(T * const item)
		{
			insert(item);
			if (!_occupant) { return true; }
			return item->priority() > _occupant->priority();
		}

		/**
		 * Exclude 'i' from scheduling
		 */
		void remove(T * const i) { _items[i->priority()].remove(i); }


		/***************
		 ** Accessors **
		 ***************/

		T * occupant() { return _occupant ? _occupant : _idle; }

		T * idle() const { return _idle; }
};

#endif /* _KERNEL__SCHEDULER_H_ */
