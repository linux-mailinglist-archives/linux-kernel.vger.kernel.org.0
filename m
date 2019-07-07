Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD2F60FF1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 12:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfGFKvX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 6 Jul 2019 06:51:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60874 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGFKvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:51:21 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8B31CCF163;
        Sat,  6 Jul 2019 12:59:51 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bluetooth: Cleanup formatting and coding style
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190623211548.1966-1-fabian.schindlatz@fau.de>
Date:   Sat, 6 Jul 2019 12:51:19 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Thomas_R=C3=B6thenbacher?= <thomas.roethenbacher@fau.de>,
        linux-kernel@i4.cs.fau.de
Content-Transfer-Encoding: 8BIT
Message-Id: <90741AAB-9936-463E-88A0-02BA37F35E3E@holtmann.org>
References: <20190623211548.1966-1-fabian.schindlatz@fau.de>
To:     Fabian Schindlatz <fabian.schindlatz@fau.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabian,

> Fix some warnings and one error reported by checkpatch.pl:
> - lines longer than 80 characters are wrapped
> - empty lines inserted to separate variable declarations from the actual
>  code
> - line break inserted after if (...)
> 
> Co-developed-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
> Cc: linux-kernel@i4.cs.fau.de
> ---
> drivers/bluetooth/bpa10x.c |  3 ++-
> drivers/bluetooth/hci_ll.c | 25 ++++++++++++++++++-------
> 2 files changed, 20 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next.

Regards

Marcel

