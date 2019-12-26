Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96B12AE93
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 21:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLZUlK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Dec 2019 15:41:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50459 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 15:41:10 -0500
Received: from [192.168.0.171] (188.147.97.8.nat.umts.dynamic.t-mobile.pl [188.147.97.8])
        by mail.holtmann.org (Postfix) with ESMTPSA id B6ED2CECEC;
        Thu, 26 Dec 2019 21:50:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v1] Bluetooth: btusb: Add support for 04ca:3021 QCA_ROME
 device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191219071857.18532-1-rjliao@codeaurora.org>
Date:   Thu, 26 Dec 2019 21:41:08 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1E02ECCD-48FF-4206-85EE-95EA29EFECD8@holtmann.org>
References: <20191219071857.18532-1-rjliao@codeaurora.org>
To:     Rocky Liao <rjliao@codeaurora.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rocky,

> USB "VendorID:04ca ProductID:3021" is a new QCA ROME USB
> Bluetooth device, let's support firmware downloading for it.

I prefer that /sys/kernel/debug/usb/devices content for this device is included in the commit message.

Regards

Marcel

