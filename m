Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD76F4D9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 21:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfGUTEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 15:04:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49479 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfGUTEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 15:04:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3B47880385; Sun, 21 Jul 2019 21:04:35 +0200 (CEST)
Date:   Sun, 21 Jul 2019 21:03:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, jpawar@cadence.com,
        kurahul@cadence.com, aniljoy@cadence.com
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Message-ID: <20190721190335.GA19831@xo-6d-61-c0.localdomain>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563733939-21214-1-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> 
> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.

I see you are using debugfs to select between DRD, peripheral-onlyh and XHCI... 

Is that good idea?

This is at least 3rd driver needing that capability, and debugfs does not
sound like a good match.

									Pavel
