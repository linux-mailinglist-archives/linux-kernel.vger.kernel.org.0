Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC5DB52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 06:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfD2Eys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 00:54:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46124 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfD2EyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id j11so4685609pff.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CXY8NMI+MMoFwyd5a0U3G9swoqWap2mhzcLLts/Z+iE=;
        b=MT3mzMT76800YDXvDZ5HeHvywukXbF/p5hE0jBqJpGYZZg1bhMX2UHmZ1HU1dvIheR
         9V3fe+IwApl8EGbBqr2IZkMENTIoZrC2hLsTBul7PX4wqT1iG/MuEFlYgfUtMUoSToFc
         7CbzrSVAtGB1V9nsEgm59WhrmtIFGM7bhpw1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CXY8NMI+MMoFwyd5a0U3G9swoqWap2mhzcLLts/Z+iE=;
        b=OVdNM5TsesyrEvYE1iSIdOjfkKe3CaiewOXf6F8m/Jo8f6K5PAW+gprgx7p4/wt2tR
         0QYij01ZTQxZOzCN8Uw/3Wq2QQkF3FdS2tcw1JddGZ1u0dqaJLEeHEwB/p2VVDYh92Mh
         tQMsj8bQ4SNiNjiSJ1PVz8zxRzVuUQuH+4apTHV0jL5QTqiqweXQVnsLudSmnaxeIEPP
         9DwTb+LdDiqP0Fqknzvex8xYwLq5aD8vtiMz0BaFzxCCHe6j3xY+KZXUH4DqmsBAlO2d
         FLRpP0aP8dMAnPlisCdUaWwAPSfGeixMY59TgPkYb8VqDKnt/kdqKlh/H6HflMA+08AI
         Xltw==
X-Gm-Message-State: APjAAAX5kr74trHHT9LDGHcxrJJGJmG1GKe1at20VIfjjrwcJNX2tjeL
        du4RAEz3RXZYi6WKRtfbY9l3zA==
X-Google-Smtp-Source: APXvYqxOmKGuDu957cqrxEQ+1VImzuI7N1RjWAr+p16Qnie6ZNUhOIBHM3h6IhCgt1zC9o45e1De9A==
X-Received: by 2002:a63:7d03:: with SMTP id y3mr55014550pgc.8.1556513648514;
        Sun, 28 Apr 2019 21:54:08 -0700 (PDT)
Received: from localhost (ppp121-45-207-92.bras1.cbr1.internode.on.net. [121.45.207.92])
        by smtp.gmail.com with ESMTPSA id j67sm74431179pfc.72.2019.04.28.21.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 21:54:07 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Matthew Garrett <mjg59@google.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr <cmr@informatik.wtf>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the running kernel image
In-Reply-To: <87wojdy8ro.fsf@dja-thinkpad.axtens.net>
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com> <059c523e-926c-24ee-0935-198031712145@au1.ibm.com> <CACdnJus9AhAAYs-R94BH7HDuuQfXjgdhdqUR6Pvk9mxbuPx1=Q@mail.gmail.com> <87wojdy8ro.fsf@dja-thinkpad.axtens.net>
Date:   Mon, 29 Apr 2019 14:54:03 +1000
Message-ID: <87tvehxvh0.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

>>> I'm thinking about whether we should lock down the powerpc xmon debug
>>> monitor - intuitively, I think the answer is yes if for no other reason
>>> than Least Astonishment, when lockdown is enabled you probably don't
>>> expect xmon to keep letting you access kernel memory.
>>
>> The original patchset contained a sysrq hotkey to allow physically
>> present users to disable lockdown, so I'm not super concerned about
>> this case - I could definitely be convinced otherwise, though.

So Mimi contacted me offlist and very helpfully provided me with a much
better and less confused justification for disabling xmon in lockdown:

On x86, physical presence (== console access) is a trigger to
disable/enable lockdown mode.

In lockdown mode, you're not supposed to be able to modify memory. xmon
allows you to modify memory, and therefore shouldn't be allowed in
lockdown.

So, if you can disable lockdown on the console that's probably OK, but
it should be specifically disabling lockdown, not randomly editing
memory with xmon.

Regards,
Daniel
