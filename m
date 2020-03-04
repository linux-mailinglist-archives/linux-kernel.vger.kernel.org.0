Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0111794E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 17:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgCDQUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 11:20:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=i6EPXcsPhf+W5yJHKSE2MmxHE7uZjMhGSjJOHrOggdc=; b=S8gzW6+gR7oJRlslNUP/b1ARaY
        3jgyftu6vahHcFT2DEary7hCm+MUfyMyuceCJuVqz55SnIBZKeQOzpjw5LanLUnL8tGIRgJk/WQR7
        B7IHthWQK0Eu52RRL6p+BXdSyWS+nUcnbXH7yDjl694NSbne4GkDR0T9brSvkg7jlGI9OXMJuhAf7
        7nK17/mFl5xnsHeLx0zhH0g+uaKxQ3B3DnR9YKpLrghWNoNJvlM3477ecj/LPGaS0NdoA2/2ySHI3
        NfLm5uQbwOETmrMB2nx5hAhjmQPCExJ7j1/+T5w2QE5ulKAc9u2XxKQWUiyKd112pNtP9B82bPG73
        VYk3svKQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9WlB-0007WO-Q9; Wed, 04 Mar 2020 16:20:37 +0000
Subject: Re: [v4] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
 <158322635301.31847.15011454479023637649.stgit@devnote2>
 <ad1e9855-4c64-53bd-7da5-f7cdafe78571@infradead.org>
 <20200304203722.8e8699c2a3e0a979aae091b1@kernel.org>
 <3a3a5f1a-3654-d96d-3b4a-dd649a366c65@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <531371ef-354a-b0fa-f69f-c8cf9ecc9919@infradead.org>
Date:   Wed, 4 Mar 2020 08:20:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3a3a5f1a-3654-d96d-3b4a-dd649a366c65@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 6:45 AM, Markus Elfring wrote:
>> What about the following?
>>
>> User can group identical parent keys together and use braces to list child keys

   The user
(as Markus noted)

>> under them.
> 
> Another wording alternative:
> 
> The user can group settings together. Curly brackets enclose a configuration then
> according to a parent context.

I slightly prefer Masami's text.

-- 
~Randy

