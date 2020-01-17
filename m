Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B90D1409E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 13:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgAQMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 07:40:18 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:46614 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQMkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:40:18 -0500
Received: by mail-qv1-f50.google.com with SMTP id u1so10600462qvk.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 04:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=EEYzszKyIEcUSg4iqz8XJMBTQPM568jpucE6cSO2l/U=;
        b=evk1J7dhPrnQM4qt0qwrFduRec8uyXznMMQKil6cinRTO+JJTAVXMKaw1qJD+PVHa+
         i0pyYtX/WQ0OAB4STCEQt1JODVxRHLTKAGzwICxbI1wNie5+GmxI17yhpYjwG5WqSXQ8
         1zMeF/2IWWaNZK3jy/j2lFzH6KrCqxWGE0W1AesqhYadj4/E8yrhHVXrJTnKyD5CcOft
         PZ01dFELmQNzLRj/poE5bk9etGYpcDM8/qKg3rLKfb7cdWavl+qWSwxfI34zSfyWz9eQ
         Mrb8VWqOHSF9wbGufmywdzwvENLE82rVcDH2NxzWbXSooyfIe0tOQhUdfCwD07B1TKuP
         HcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=EEYzszKyIEcUSg4iqz8XJMBTQPM568jpucE6cSO2l/U=;
        b=oQCSMje5BPu8vUNqQendesBNQ0/yyloiL9awO2E2ad9HTIdiWOthg/hxPeXisQFh9D
         PY6WDh2oDEvnNgun9OC2DX4MpBFO5OqniSBRHdF1p7yU4f5HsAvWHl6UNAK2ldtmaLFV
         8icjL+wZjZdKz8p279EbsjpIJE0AC7VAMBx2KpKcLkd/bzMuob/FAQs2R76mIuJ2QQF0
         ayUwGaGpuH3xtN+ov/AdnVWhOwv6x8TKfI8tAEbWRLhTSDD1Hh80lvM1dqQrHGqw2uDQ
         2dM+dRaWcYiiEK3vKyI/SLuvUR9CL6vLUWeIQUbpHLSSYS65tHjJO3jQkyqyeZh/0o28
         bhnA==
X-Gm-Message-State: APjAAAWYa2f2KvlVu2NOcms4EbU6GD/V2/SEy5IvakWocUEZIaJPUHJv
        mFw+rmBDlUFeIpOe838ueCzCDEsw3yfu8Q==
X-Google-Smtp-Source: APXvYqxaTaQTCBWUWSYM2ZkSOqMtEhsiGrDIXketYgP5z6ddSb2DBWc9zQGscIbC9h1BTeB0CKoq+Q==
X-Received: by 2002:ad4:50d2:: with SMTP id e18mr7622075qvq.9.1579264817318;
        Fri, 17 Jan 2020 04:40:17 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e2sm11582651qkl.3.2020.01.17.04.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 04:40:16 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with printk()
Date:   Fri, 17 Jan 2020 07:40:15 -0500
Message-Id: <6BED7E12-CC3B-4AED-ACC8-F3533D3F3C70@lca.pw>
References: <d7068679-e28a-98a9-f5b8-49ea47f7c092@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
In-Reply-To: <d7068679-e28a-98a9-f5b8-49ea47f7c092@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 3:51 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> -> you are accessing the pageblock without the zone lock. It could
> change to "isolate" again in the meantime if I am not wrong!

Since we are just dumping the state for debugging, it should be fine to acce=
pt a bit inaccuracy here due to racing. I could put a bit comments over ther=
e.=
