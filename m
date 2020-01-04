Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6964E1301A1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 10:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgADJnW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 4 Jan 2020 04:43:22 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42864 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgADJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 04:43:22 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 03BDACED12;
        Sat,  4 Jan 2020 10:52:35 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Drive RTS only for BCM43438
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1577887294-6089-1-git-send-email-wahrenst@gmx.net>
Date:   Sat, 4 Jan 2020 10:43:19 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ devel list <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <77E11D2B-B230-4AAA-99ED-35029A781028@holtmann.org>
References: <1577887294-6089-1-git-send-email-wahrenst@gmx.net>
To:     Stefan Wahren <wahrenst@gmx.net>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

> The commit 3347a80965b3 ("Bluetooth: hci_bcm: Fix RTS handling during
> startup") is causing at least a regression for AP6256 on Orange Pi 3.
> So do the RTS line handing during startup only on the necessary platform.
> 
> Fixes: 3347a80965b3 ("Bluetooth: hci_bcm: Fix RTS handling during startup")
> Reported-by: Ondřej Jirman <megous@megous.com>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
> drivers/bluetooth/hci_bcm.c | 21 +++++++++++++++++----
> 1 file changed, 17 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

