Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC4C1BA79
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfEMP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 11:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfEMP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:58:05 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2E420873;
        Mon, 13 May 2019 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557763085;
        bh=MQrt7hk7GKWBs2p7TCVFsqZzTnTwmWoYq3R9MsShl68=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o5R3D0mgAlkwf6pyaLHh/21/h1y/Hgyom3AFUlqLvzy5YFAFCaMJp0yOcluPpS7zs
         ybL53+kCkAKr6SUdAOKet1cha5beD4qF4M0I1+o7mqEbNPNol11tLlEd1Qto8Qh5cN
         JvYlVOVIgCp296Qw1xpE/ixu84Crj/SdCXyrtSGI=
Subject: Re: linux-next: Fixes tag needs some work in the kselftest tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20190514010540.6fbe70e0@canb.auug.org.au>
From:   shuah <shuah@kernel.org>
Message-ID: <a4ecb5ac-86ec-ac8d-a250-7073351ad23b@kernel.org>
Date:   Mon, 13 May 2019 09:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514010540.6fbe70e0@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/19 9:05 AM, Stephen Rothwell wrote:
> Hi Shuah,
> 
> In commit
> 
>    e64ee1f5dc1a ("selftests: fix bpf build/test workflow regression when KBUILD_OUTPUT is set")
> 
> Fixes tag
> 
>    Fixes: commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")
> 
> has these problem(s):
> 
>    - leading word 'commit' unexpected
> 

Sorry this is my bad. I will fix it.

thanks,
-- Shuah
