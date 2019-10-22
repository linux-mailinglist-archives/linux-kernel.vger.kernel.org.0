Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4303CE0852
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbfJVQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:09:38 -0400
Received: from mail.netline.ch ([148.251.143.178]:59740 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJVQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:09:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 35BBB2A6046;
        Tue, 22 Oct 2019 18:09:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id sVCE-vb1yYoP; Tue, 22 Oct 2019 18:09:36 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.245.116])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id CC8B32A6045;
        Tue, 22 Oct 2019 18:09:35 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.92.2)
        (envelope-from <michel@daenzer.net>)
        id 1iMwiw-0007Va-4e; Tue, 22 Oct 2019 18:09:30 +0200
Subject: Re: radeon Disabling GPU acceleration (WB disabled?)
To:     Meelis Roos <mroos@linux.ee>
References: <24b5f681-df58-7663-af7c-9fa9b9158be9@linux.ee>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <61646cbe-c4a9-cef1-d586-f3ac794b998a@daenzer.net>
Date:   Tue, 22 Oct 2019 18:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <24b5f681-df58-7663-af7c-9fa9b9158be9@linux.ee>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-20 11:21 p.m., Meelis Roos wrote:
> I tried 5.2, 5.3 and 5.4-rc4 on my old Fujitsu RX220 with integrated
> Radeon RV100. Dmesg tells that GPU acceleration is disabled. I do not
> know if it has been enabled in the past - no old kernels handy at the
> moment.
> 
> From dmesg it looks like something with MTRR maybe: WB disabled.

That's harmless.


> [    8.535975] [drm] Driver supports precise vblank timestamp query.
> [    8.535981] radeon 0000:00:05.0: Disabling GPU acceleration

This looks like drm_irq_install returns an error in radeon_irq_kms_init.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
