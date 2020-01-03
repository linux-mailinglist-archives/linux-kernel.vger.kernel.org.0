Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7272412F53C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 09:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgACISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 03:18:10 -0500
Received: from fgw21-4.mail.saunalahti.fi ([62.142.5.108]:20569 "EHLO
        fgw21-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbgACISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:18:09 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-105-219-nat.elisa-mobile.fi [85.76.105.219])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 924a84c9-2e01-11ea-bfc2-005056bdd08f;
        Fri, 03 Jan 2020 10:18:07 +0200 (EET)
Date:   Fri, 3 Jan 2020 10:18:07 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: v5.5-rc4: OMAP build failure
Message-ID: <20200103081807.GE15023@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Build fails when CONFIG_RESET_CONTROLLER is not set:

  LD      .tmp_vmlinux1
arm-linux-gnueabi-ld: drivers/soc/ti/omap_prm.o: in function `omap_prm_reset_init':
/home/aakoskin/git/devel/linux/drivers/soc/ti/omap_prm.c:345: undefined reference to `devm_reset_controller_register'
make[5]: *** [/home/aakoskin/git/devel/linux/Makefile:1078: vmlinux] Error 1

Some missing dependency?

A.
