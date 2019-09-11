Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EABAFE82
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 16:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfIKORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 10:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfIKORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:17:23 -0400
Received: from linux-8ccs (ip5f5ade65.dynamic.kabel-deutschland.de [95.90.222.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A7320863;
        Wed, 11 Sep 2019 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568211443;
        bh=b4iSNKUkkqOMkrk6WOdpnuGZCrYixVqCa4JRi1BlVWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iq5asBuN+RLMcXUOQC9lTCGWGvd42wkeb07mMreF+sjR5fBuKThs8W5Xh+olgm6h+
         yaPJ36EJBTqNFnP8ITIez3j8AMlkEa30GO8ZyYRzI89j8O/8/qEoVUz4zliWWv8ZAq
         qr+18GD+GE5EgPZWN1a9xu2ZJY/nFPXkkZoRUDxA=
Date:   Wed, 11 Sep 2019 16:17:07 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] module: remove redundant 'depends on MODULES'
Message-ID: <20190911141706.GA640@linux-8ccs>
References: <20190909110408.21832-1-yamada.masahiro@socionext.com>
 <20190911114559.GA6189@linux-8ccs.fritz.box>
 <CAK7LNATn3Gde_52uhv683_tWPrL3amHAbc5g-_WyHRR7TVh9sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNATn3Gde_52uhv683_tWPrL3amHAbc5g-_WyHRR7TVh9sw@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [11/09/19 21:21 +0900]:
>On Wed, Sep 11, 2019 at 8:46 PM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> +++ Masahiro Yamada [09/09/19 20:04 +0900]:
>> >These are located in the 'if MODULES' ... 'endif' block.
>> >
>> >Remove the redundant dependencies.
>> >
>> >Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> Acked-by: Jessica Yu <jeyu@kernel.org>
>>
>
>Could you queue these two patches to your tree?
>
>Thanks.

Ah, I thought they were going to the kbuild tree. But yes, I'll take
them through modules-next.

Thanks,

Jessica
