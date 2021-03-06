/*
 * \brief  Serial output driver for core
 * \author Martin Stein
 * \date   2012-04-23
 */

/*
 * Copyright (C) 2012-2013 Genode Labs GmbH
 *
 * This file is part of the Genode OS framework, which is distributed
 * under the terms of the GNU General Public License version 2.
 */

#ifndef _SERIAL_H_
#define _SERIAL_H_

/* core includes */
#include <board.h>

/* Genode includes */
#include <drivers/uart/pl011_base.h>

namespace Genode
{
	/**
	 * Serial output driver for core
	 */
	class Serial : public Pl011_base
	{
		public:

			/**
			 * Constructor
			 *
			 * \param baud_rate  targeted transfer baud-rate
			 */
			Serial(unsigned const baud_rate)
			:
				Pl011_base(Board::PL011_0_MMIO_BASE,
				           Board::PL011_0_CLOCK, baud_rate)
			{ }
	};
}

#endif /* _SERIAL_H_ */
