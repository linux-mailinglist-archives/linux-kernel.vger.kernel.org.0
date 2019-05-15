Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39B621EA70
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEOIsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 04:48:36 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:58292 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbfEOIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:48:36 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E97EF2E146D;
        Wed, 15 May 2019 11:48:33 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Q7pQ1sTs55-mXwKadUT;
        Wed, 15 May 2019 11:48:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1557910113; bh=RBKOGGXjvQMTQzfr1KxZ/9oyUSl618uUSUuLqd4U4J4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=xS6pYk6lclpU7VNMA86o90Cjw5stbFWI+4tB+0YsgkUrheiouBQ8AFz8MpyH3KX6B
         cYl8QrQFZIGVKhNgLsQ5GI7hC5vZalPybRoqEZphXJ6kxTMy+pJlDcuospumbfhH/6
         AX9OFu7taypLf891OGXJ8oBpDBEjmuIz6A49Iw8Q=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ed19:3833:7ce1:2324])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id F0Vfe9DM2Y-mXlCWMAt;
        Wed, 15 May 2019 11:48:33 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: mm: use down_read_killable for locking mmap_sem in
 access_remote_vm
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, oleg@redhat.com
References: <20190515083825.GJ13687@blackbody.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <11ee83c8-5f0f-0950-a588-037bdcf9084e@yandex-team.ru>
Date:   Wed, 15 May 2019 11:48:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515083825.GJ13687@blackbody.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.2019 11:38, Michal Koutný wrote:
> Hi,
> making this holder of mmap_sem killable was for the reasons of /proc/...
> diagnostics was an idea I was pondeering too. However, I think the
> approach of pretending we read 0 bytes is not correct. The API would IMO
> need to be extended to allow pass a result such as EINTR to the end
> caller.
> Why do you think it's safe to return just 0?

This function ignores any error like reading from unmapped area and
returns only size of successful transfer. It never returned any error codes.

> 
> Michal
> 
