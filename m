Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF4154ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 19:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgBFSKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 13:10:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFSKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=zy3jx1sb6SbfQ14MKWRxT8AuGdUe/Syyw3wgrLMnIC0=; b=GGX8rgBqJ410BmIftUbr2bz3aD
        Ufu2XYIPqJjOuuWSODFEiKvn4aYivQBPyXrRGO6eMUtne+eiySF35kTSZz0OSZa1etZVUasN/JeKd
        xZ5x/30Lwcp6nagv36LWOu9wrFQgCLtAmkMOyF4NC/UOoyxrAw9PjJdPAl1kcPz3aip+V2rXkYO/M
        wgoF/edvc04e7L81zk1eZruvqJo1BmQjhpJol+poe+aAbOBceSypqqBOEDGK28ageA1STOHf3KhKp
        zFcl+LiRjrR3oya5PiWGJPYGlEgH3PyzXH5zJRqoPH65pNP3PO+3LFquf3VfaImDROzCx6hOhUM5b
        FktchS3w==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izlbh-0001ze-Fd; Thu, 06 Feb 2020 18:10:29 +0000
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
To:     Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200114210316.450821675@goodmis.org>
 <20200114210336.259202220@goodmis.org> <20200206115405.GA22608@zn.tnic>
 <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
 <20200206175858.GG9741@zn.tnic>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7280e507-cafd-f981-88b5-0e7d375e26d4@infradead.org>
Date:   Thu, 6 Feb 2020 10:10:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206175858.GG9741@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 9:58 AM, Borislav Petkov wrote:
> On Thu, Feb 06, 2020 at 11:41:00PM +0900, Masami Hiramatsu wrote:
>> Oh, you are not the first person asked that :)

(that would be me AFAIK)

>>
>> https://lkml.org/lkml/2019/12/9/563
>>
>> And yes, I think this is important that will useful for most developers
>> and admins. Since the bootconfig already covers kernel and init options,
>> this can be a new standard way to pass args to kernel boot.
> 
> Aha, so Steve and you believe this will become the next great thing
> after sliced bread. Sorry but I remain sceptical. :)

old news: some Kconfig symbols are Special & Important.  ;)

I agree with you (as I also disagreed with "default y").


> I would've done it differently: have it default 'n' and once it turns
> out that the major distros have enabled it and *actually* use it, *then*
> simply remove the config option. Like we usually do with functionality.
> Not the other way around.
> 
> In any case, I've disabled it on my machines and will wait for it
> missing to come back and bite me. :-P


-- 
~Randy

