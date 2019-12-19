Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE91265D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 16:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLSPdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 10:33:02 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35611 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfLSPdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:33:02 -0500
Received: by mail-yb1-f194.google.com with SMTP id a124so2327802ybg.2;
        Thu, 19 Dec 2019 07:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TopGJXgE0pGE0o7+b7t+7rYwUwd2NKiz9RqJZ3cMuNI=;
        b=HWYZBa3sPP4qtAEwaw6IHl5eCFbpaTMsSYpIV/pfoVDvDlqdKgi2uRdFN4O2IFsxDy
         VNZolE13SL3GcOVx+Z+SJJ1hO9Xkt35MMMCK0THi6oZE3LVCFsdzhpg7gv6iebp4hZFG
         8ZeNNnzsdLOS12ul/1GOH/Hy2lROirEwEIvKU/QBjrhxF3woTd6UI/wleq7Sv2DHzPmO
         hiM5N/9owX30U6GTgPvqn+eg60ZwrfdCa3dxZPpCiZpYiaZKG4A5TevVhSWeFT3wRMvz
         /oW3Eai9orQqztgrVXig0kqoSABfIPfJKQ/DP9GBl+xzzVSaBFUqwbkLABAoXz3LhRC5
         xmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TopGJXgE0pGE0o7+b7t+7rYwUwd2NKiz9RqJZ3cMuNI=;
        b=DxFcNbyPK+NUzEeY+YApzyhBa6SX9aZfI+jSuXZkRO7Qvcx8ivGuZhcnI1iolH2FQU
         /YkeMMTiQPkADpdPxMk4YUeBUYLIqlH1XNTSt6/M9RTiLfOHhMtRSBFFMJuaJI3+hg41
         b7vJfLkmdMvepX8d5wfyHM6+mjALg0IBxk1XtxOvL/SsKun9xLr/Ww5pG0NP4+p2QbVZ
         c6sdWdsw3uIqk746AjwAZKCfUyPmEJ01p5iCwF188I5DOwi9jBvcZ3Y3AMz9TryobxSS
         8Gcx2uzgcbaTPLRiKXnyPsbdWC1cEiG2+NZ2aXU7RPW5LDOg72EA+Bj6T81J4Z0+AG+9
         bvAQ==
X-Gm-Message-State: APjAAAV3/2KNX5mX/WXfzC4lnWPF7eON38DBJDUXFD+jIcnmTRt5L5JR
        J4OSIzQ9QLGo1FpAjnoALn5cj0qX
X-Google-Smtp-Source: APXvYqx+tWVCU/vQqx+U4IV8dk0Cc0Zi6T60zmScU8f4PYukufCJQPYpUPgDZundvRbnN064fkYY8w==
X-Received: by 2002:a25:d410:: with SMTP id m16mr5113500ybf.393.1576769580928;
        Thu, 19 Dec 2019 07:33:00 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id f22sm2778691ywb.104.2019.12.19.07.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 07:33:00 -0800 (PST)
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20191211232345.24810-1-robh@kernel.org>
 <CAL_JsqKfV-4mx_uidUupQJT4qfq+y+qx1=S=Du-Qsaweh4CPUQ@mail.gmail.com>
 <20191212130539.loxpr2hbfcodh4gz@linutronix.de>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <eaf5e27b-696f-bede-520c-cf6a847a5250@gmail.com>
Date:   Thu, 19 Dec 2019 09:33:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191212130539.loxpr2hbfcodh4gz@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 7:05 AM, Sebastian Andrzej Siewior wrote:
> On 2019-12-11 17:48:54 [-0600], Rob Herring wrote:
>>> -       if (phandle_cache) {
>>> -               if (phandle_cache[masked_handle] &&
>>> -                   handle == phandle_cache[masked_handle]->phandle)
>>> -                       np = phandle_cache[masked_handle];
>>> -               if (np && of_node_check_flag(np, OF_DETACHED)) {
>>> -                       WARN_ON(1); /* did not uncache np on node removal */
>>> -                       of_node_put(np);
>>> -                       phandle_cache[masked_handle] = NULL;
>>> -                       np = NULL;
>>> -               }
>>> +       if (phandle_cache[handle_hash] &&
>>> +           handle == phandle_cache[handle_hash]->phandle)
>>> +               np = phandle_cache[handle_hash];
>>> +       if (np && of_node_check_flag(np, OF_DETACHED)) {
>>> +               WARN_ON(1); /* did not uncache np on node removal */
>>
>> BTW, I don't think this check is even valid. If we failed to detach
>> and remove the node from the cache, then we could be accessing np
>> after freeing it.
> 
> this is kmalloc()ed memory which is always valid. If the memory is

It was kmalloc()ed memory _before_ applying Rob's patch.  It no longer
is kmalloc()ed, so the rest of this discussion no longer applies.

-Frank

> already re-used then
> 	handle == phandle_cache[handle_hash]->phandle
> 
> will fail (the check, not the memory access itself). If the check
> remains valid then you can hope for the OF_DETACHED flag to trigger the
> warning.
> 
>> Rob
> 
> Sebastian
> 

