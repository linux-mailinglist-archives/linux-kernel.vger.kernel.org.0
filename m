Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB910C620
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 10:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfK1Joh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 04:44:37 -0500
Received: from ns.iliad.fr ([212.27.33.1]:58002 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfK1Joh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:44:37 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1C52C2056B;
        Thu, 28 Nov 2019 10:44:36 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 02CAB20234;
        Thu, 28 Nov 2019 10:44:35 +0100 (CET)
Subject: Re: [PATCH] KVM: vgic: Use warpper function to lock/unlock all vcpus
 in kvm_vgic_create()
To:     Auger Eric <eric.auger@redhat.com>
References: <1574910551-14351-1-git-send-email-linmiaohe@huawei.com>
 <cdd7ef36-70ae-3e56-2ea3-48d7051991c3@redhat.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <7edeadc5-4af8-9539-59a5-d8f823de7fc0@free.fr>
Date:   Thu, 28 Nov 2019 10:44:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cdd7ef36-70ae-3e56-2ea3-48d7051991c3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Nov 28 10:44:36 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2019 10:07, Auger Eric wrote:

> s/warpper/wrapper and also in the title.

Warp functions sounded very cool ;-)

"Beam me up, Scotty. There's no intelligent life down here."

Regards.
