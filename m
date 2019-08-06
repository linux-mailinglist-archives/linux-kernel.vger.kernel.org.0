Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C757F83941
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfHFTAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 15:00:25 -0400
Received: from albireo.enyo.de ([5.158.152.32]:52612 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFTAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:00:24 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1hv4h3-0002lu-RA; Tue, 06 Aug 2019 19:00:21 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1hv4h3-0007iX-OO; Tue, 06 Aug 2019 21:00:21 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's inability to gracefully handle low memory pressure
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
Date:   Tue, 06 Aug 2019 21:00:21 +0200
In-Reply-To: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com> (Artem
        S. Tashkinov's message of "Sun, 4 Aug 2019 09:23:17 +0000")
Message-ID: <874l2u3yre.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Artem S. Tashkinov:

> There's this bug which has been bugging many people for many years
> already and which is reproducible in less than a few minutes under the
> latest and greatest kernel, 5.2.6. All the kernel parameters are set to
> defaults.
>
> Steps to reproduce:
>
> 1) Boot with mem=4G
> 2) Disable swap to make everything faster (sudo swapoff -a)
> 3) Launch a web browser, e.g. Chrome/Chromium or/and Firefox
> 4) Start opening tabs in either of them and watch your free RAM decrease

Do you see this with Intel graphics?  I think these drivers still use
the GEM shrinker, which effectively bypasses most kernel memory
management heuristics.
