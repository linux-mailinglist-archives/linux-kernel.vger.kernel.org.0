Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931E46D36F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbfGRSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 14:04:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfGRSEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 875EA2BFCA;
        Thu, 18 Jul 2019 18:04:39 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 679025D71A;
        Thu, 18 Jul 2019 18:04:34 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm, slab: Show last shrink time in us when
 slab/shrink is read
From:   Waiman Long <longman@redhat.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20190717202413.13237-1-longman@redhat.com>
 <20190717202413.13237-3-longman@redhat.com>
 <0100016c04e1562a-e516c595-1d46-40df-ab29-da1709277e9a-000000@email.amazonses.com>
 <6fb9f679-02d1-c33f-2d79-4c2eaa45d264@redhat.com>
Organization: Red Hat
Message-ID: <9d35da26-6d85-d879-c966-3577bdb0cf02@redhat.com>
Date:   Thu, 18 Jul 2019 14:04:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6fb9f679-02d1-c33f-2d79-4c2eaa45d264@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 18 Jul 2019 18:04:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/19 10:36 AM, Waiman Long wrote:
>>> CONFIG_SLUB_DEBUG depends on CONFIG_SYSFS. So the new shrink_us field
>>> is always available to the shrink methods.
>> Aside from minimal systems without CONFIG_SYSFS... Does this build without
>> CONFIG_SYSFS?
> The sysfs code in mm/slub.c is guarded by CONFIG_SLUB_DEBUG which, in
> turn, depends on CONFIG_SYSFS. So if CONFIG_SYSFS is off, the shrink
> sysfs methods will be off as well. I haven't tried doing a minimal
> build. I will certainly try that, but I don't expect any problem here.

I have tried a tiny config with slub. There was no compilation problem.

-Longman

