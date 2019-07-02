Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28215D6A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 21:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGBTMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 15:12:10 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:44967 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:12:10 -0400
Received: by mail-pl1-f175.google.com with SMTP id t7so866678plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ustizs9nQ/dvH8f3l0VeRsX7a+gE2MyRDhi2ExuynrQ=;
        b=KYjUX95hqXNvTfv32exnncUWRJEABX4uz/Gycd9AFxTIST4OXEiGp4h81QjfCiwIH7
         ycunBDhPiYn7b+bF4IYG/9nVqdpsTIUVKM6pP0OyRG8kCdFjOHAzw4Wa/lu6Z6d2u4d5
         PaScNBBegnKeTlIExx5CGoRSHq4bnnGkAkH2VKz+Fgje571NP5805RomuRs3D20LQZkw
         lCxjPGH/aymTPbHLFypkVaN9qcfE5RKJIyQ6CyOAL/HkqGfWVZER54G9nOVrdbTFy8/g
         FXpYf6REqgjmdxuLG+qlfCONPcsujmuGvEVQeMm4pzqqYcntCojNNQfHWLZQALSjhCW3
         8MHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ustizs9nQ/dvH8f3l0VeRsX7a+gE2MyRDhi2ExuynrQ=;
        b=Sq0BMBlH+l8qOH4B+RmsA6lIBXB53npIVHpRN6lDbEn0ETwsCviBNIu4sZ0uJ4zXMm
         aI4N3LFkZ/zo3UPUIo4RMHANOaSxw5JYxyt9S5ptLbEkR2vT+W3Y+nZaoUDhpz8EDMEy
         WZco354LY8kMrTMalJB0zcxoDpWro1s3TtBYK1OHY0jqgUkYf+DkT/YbyJ+YiYc7rj5E
         S7TCavfecbArk5c38/2O7qOZPqssy54QkHN/odroM+KPMbUvZDJcFR3FdejAEUTwwsZn
         oiTQtzTNEftYlTT7HNr0mAH9ZH1+hcLIGPmWSUeqQ1wX+njVyOVOWo9DQG1L7stZL1Vp
         ltMQ==
X-Gm-Message-State: APjAAAWDZh42vsVEvneJN0PrmpuspJ76xr8/uJjuknCNIxLHVTLMsFcG
        pw9iIHJGTIqEri+K51IsjPnxIg==
X-Google-Smtp-Source: APXvYqz4wXXllh26Sw2vwZ0czX/JHY7+mfDNBiC+q6EuLJRFW2nSu4csXD4xq7TUdIQ+mg9+YBbouQ==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr36862985plp.47.1562094729587;
        Tue, 02 Jul 2019 12:12:09 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l44sm3000865pje.29.2019.07.02.12.12.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 12:12:08 -0700 (PDT)
Date:   Tue, 2 Jul 2019 12:12:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Waiman Long <longman@redhat.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH-next v2] mm, memcg: Add ":deact" tag for reparented kmem
 caches in memcg_slabinfo
In-Reply-To: <20190627184324.5875-1-longman@redhat.com>
Message-ID: <alpine.DEB.2.21.1907021211570.67286@chino.kir.corp.google.com>
References: <20190627184324.5875-1-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019, Waiman Long wrote:

> With Roman's kmem cache reparent patch, multiple kmem caches of the same
> type can be seen attached to the same memcg id. All of them, except
> maybe one, are reparent'ed kmem caches. It can be useful to tag those
> reparented caches by adding a new slab flag "SLAB_DEACTIVATED" to those
> kmem caches that will be reparent'ed if it cannot be destroyed completely.
> 
> For the reparent'ed memcg kmem caches, the tag ":deact" will now be
> shown in <debugfs>/memcg_slabinfo.
> 
> [v2: Set the flag in the common code as suggested by Roman.]
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: David Rientjes <rientjes@google.com>
