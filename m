Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD05044ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfFMSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 14:34:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:21227 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfFMSeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:34:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 11:34:08 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 13 Jun 2019 11:34:05 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 13 Jun 2019 21:34:05 +0300
Date:   Thu, 13 Jun 2019 21:34:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3 v6] tty/serial/8250: use mctrl_gpio helpers
Message-ID: <20190613183405.GT2640@lahna.fi.intel.com>
References: <20190613154542.32438-1-sr@denx.de>
 <20190613154542.32438-3-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613154542.32438-3-sr@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 05:45:42PM +0200, Stefan Roese wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch permits the usage for GPIOs to control
> the CTS/RTS/DTR/DSR/DCD/RI signals.
> 
> Changed by Stefan:
> Only call mctrl_gpio_init(), if the device has no ACPI companion device
> to not break existing ACPI based systems. Also only use the mctrl_gpio_
> functions when "gpios" is available.
> 
> Use MSR / MCR <-> TIOCM wrapper functions.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
