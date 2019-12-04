Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0AD112124
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 02:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLDBtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 20:49:40 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44440 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfLDBtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:49:40 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id E5263CEC82;
        Wed,  4 Dec 2019 02:58:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Input: uinput - Add UI_SET_UNIQ ioctl handler
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191127185139.65048-1-abhishekpandit@chromium.org>
Date:   Wed, 4 Dec 2019 02:49:37 +0100
Cc:     linux-input@vger.kernel.org,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Kirill Smelkov <kirr@nexedi.com>
Content-Transfer-Encoding: 7bit
Message-Id: <581F56B1-035C-4339-AF10-464BD3E984F4@holtmann.org>
References: <20191127185139.65048-1-abhishekpandit@chromium.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> Support setting the uniq attribute of the input device. The uniq
> attribute is used as a unique identifier for the connected device.
> 
> For example, uinput devices created by BlueZ will store the address of
> the connected device as the uniq property.

you might also then want to add HIDIOCGRAWUNIQ support to the hidraw driver.

Regards

Marcel

