Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D60F916F7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 06:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBZFwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 00:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgBZFwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:52:01 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA33F206E2;
        Wed, 26 Feb 2020 05:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582696321;
        bh=adrQAt83Jz1VYJQR0Ydtz4tKVFHlHwdEBeI/YBS3ymM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vsQd00aKR+6P4r5gOMoVfbMk6ondEC5mSm/2hSJS7W1hIYh83hmJMf9EKPEEgSic1
         6BaE9Gp4pYu3B1R6w18sTIElDLFHDWd/4GUAjo7eSOHnnIL6TsKJwuKzzubQSdBKLp
         Q645Km4twIMAN/R7ohTt4wRlvvnsjj7phdpN1+1A=
Subject: Re: [patch 01/24] x86/traps: Split trap numbers out in a seperate
 header
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.285655538@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <3083fa19-8eec-0902-d4fe-7274f420f373@kernel.org>
Date:   Tue, 25 Feb 2020 21:52:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225222648.285655538@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:16 PM, Thomas Gleixner wrote:
> So they can be used in ASM code. For this it is also necessary to convert
> them to defines. Will be used for the rework of the entry code.
> 

Reviewed-by: Andy Lutomirski <luto@kernel.org>
