Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F11122FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfLQPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 10:17:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37105 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfLQPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:17:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so5789175qky.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QBbJhTwA/z9GheRdVz6DmV0ve21qD4tE529ywgzTv4I=;
        b=d9bCdpSbGIQ2bZQYmFNSt27dYg2M8iWZwhztIVSpbfasIXUPfe9wfODDgBXYwS+JyO
         Gv3TTGJk82AvVWFURXKuscdcGA0HsfV01pD/QIDsVJmelRXOfAde709zspdbcG8ICcc7
         7TNB7KXnhm1FIo4TfOcfXQvk5nlWUU9HlOKjB4BCaP67Vuf1CgtKnicQw9mirkKllLU2
         M/a7YslEdG6U+m8J2FZ77M+8bRBnh3JeZWOf4vPXkFIzi7HAeKhBmRNHQe1i7gyA1pzn
         a8+ey1AIdl0lgF0SWzVjIXgYk2NCOn6AkDxukN3hUDa+fNb/qaSLFPWl6523TIa7FcdY
         zL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QBbJhTwA/z9GheRdVz6DmV0ve21qD4tE529ywgzTv4I=;
        b=dz+1Ed0pW8gAzENXNgdyD1OUcil2GcJIPEQIA7f1XL37Pe/1Nscce546uNpwPMfKjr
         I3D2g/vyn4yy4YawH2ofDO08CAT0ZVODDc4EloQQTnoPS4OkD4DBLeB31Q19XArildxn
         KPR3JcIwu0VGigUvxGHQprqbp0GxtYbAOZaaLmQ3XZ/FVCKPuwm3/t1HlYV3oWaIyXwt
         tPdatT+BsOVV7F3K8U2qAjgz5SjaK4ZTnBXy9LEor/xmXmK1HULiZyEjCtbTkZ/+Nz67
         Xi6B7gGj3GIsaURcvaWqqalocDsQKtPNTqxY2tyPbVQjG2SHb5o9n4jrk09LoGo8Myk5
         JQpw==
X-Gm-Message-State: APjAAAW2ScZjO5+GZGCWByDn/3O0j6NHJjZyv9KP/6gxdlX83in0l4pW
        fUWWV5/dXId/xPmJDnLVI5Fs+Q==
X-Google-Smtp-Source: APXvYqxc4OvUcMuruBVNLedZUEl90a9Pdz8xXR4S1pf38oV2+oQQJTx99hLJYlWM6tZGPH1Gp7jarA==
X-Received: by 2002:a37:6294:: with SMTP id w142mr5114586qkb.284.1576595832242;
        Tue, 17 Dec 2019 07:17:12 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t7sm7120087qkm.136.2019.12.17.07.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:17:11 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under CONFIG_MMU
Date:   Tue, 17 Dec 2019 10:17:10 -0500
Message-Id: <E7311A37-F5D9-4248-A51A-9B105A49A923@lca.pw>
References: <20191217151343.GC7272@dhcp22.suse.cz>
Cc:     Chris Down <chris@chrisdown.name>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217151343.GC7272@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 17, 2019, at 10:13 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> I do understand the general purpose of the warning. I am simply not sure
> the kernel tree is a good candidate with a huge number of different
> config combinations that might easily result in warnings which would
> tend to result in even more ifdeferry than we have.

Yes, compiling test without real-world use case is evil. Once we ignore the e=
vil, it becomes much more manageable.=
