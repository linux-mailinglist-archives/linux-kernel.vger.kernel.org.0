Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C101700F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 15:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBZOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 09:20:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:49564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgBZOUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:20:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 312D1B1FC;
        Wed, 26 Feb 2020 14:20:03 +0000 (UTC)
Message-ID: <1582726796.17520.28.camel@suse.com>
Subject: Re: [PATCH v2 5/8] usb: mausb_host: Introduce PAL processing
From:   Oliver Neukum <oneukum@suse.com>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Date:   Wed, 26 Feb 2020 15:19:56 +0100
In-Reply-To: <659eab4d-a995-d372-2c46-8b3d72ba13bc@displaylink.com>
References: <659eab4d-a995-d372-2c46-8b3d72ba13bc@displaylink.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

+       atomic_inc(&urb->use_count);
+
+       mausb_print_urb(urb);
+
+       /*
+        * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where it
+        * should not, so it is breaking the USB drive on the linux
+        */
+       urb->transfer_flags &= ~URB_SHORT_NOT_OK;

This is extremely drastic and will break drivers. Which driver causes
the problems?

	Regards
		Oliver


