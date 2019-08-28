Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8AA026C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfH1NBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:01:37 -0400
Received: from ozlabs.org ([203.11.71.1]:53577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1NBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:01:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46JQqK61lWz9sBF;
        Wed, 28 Aug 2019 23:01:33 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Scott Wood <oss@buserror.net>
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com, Jason Yan <yanaijie@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 00/12] implement KASLR for powerpc/fsl_booke/32
In-Reply-To: <827cc152757906a0ebc04bbe56cdf44683721eb4.camel@buserror.net>
References: <20190809100800.5426-1-yanaijie@huawei.com> <ed96199d-715c-3f1c-39db-10a569ba6601@huawei.com> <529fd908-42d6-f96f-daa2-9010f3035879@huawei.com> <878srf4cjk.fsf@concordia.ellerman.id.au> <827cc152757906a0ebc04bbe56cdf44683721eb4.camel@buserror.net>
Date:   Wed, 28 Aug 2019 23:01:28 +1000
Message-ID: <87h861v3yv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Wood <oss@buserror.net> writes:
> On Tue, 2019-08-27 at 11:33 +1000, Michael Ellerman wrote:
>> Jason Yan <yanaijie@huawei.com> writes:
>> > A polite ping :)
>> > 
>> > What else should I do now?
>> 
>> That's a good question.
>> 
>> Scott, are you still maintaining FSL bits, 
>
> Sort of... now that it's become very low volume, it's easy to forget when
> something does show up (or miss it if I'm not CCed).  It'd probably help if I
> were to just ack patches instead of thinking "I'll do a pull request for this
> later" when it's just one or two patches per cycle.

Yep, understand. Just sending acks is totally fine if you don't have
enough for a pull request.

cheers
