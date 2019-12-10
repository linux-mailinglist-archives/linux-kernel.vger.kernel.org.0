Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698B3118FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 19:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfLJSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 13:32:38 -0500
Received: from gentwo.org ([3.19.106.255]:47374 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfLJSci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:32:38 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 8B0DC3ED44; Tue, 10 Dec 2019 18:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 8A2BF3E95D;
        Tue, 10 Dec 2019 18:32:37 +0000 (UTC)
Date:   Tue, 10 Dec 2019 18:32:37 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Qian Cai <cai@lca.pw>
cc:     Daniel Wagner <dwagner@suse.de>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep warns: cpu_hotplug_lock.rw_sem --> slab_mutex -->
 kn->count#39
In-Reply-To: <2F924F88-8146-4868-9099-D824EAFA840E@lca.pw>
Message-ID: <alpine.DEB.2.21.1912101829170.14347@www.lameter.com>
References: <20191209182418.7vxer6vmre67ewvt@beryllium.lan> <alpine.DEB.2.21.1912092029080.6020@www.lameter.com> <2F924F88-8146-4868-9099-D824EAFA840E@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-1172478698-1576002757=:14347"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-1172478698-1576002757=:14347
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 9 Dec 2019, Qian Cai wrote:

> It happens to me too with a probably easier to trigger deadlock. Basically, we have,
>
> memcg_create_kmem_cache():
> cpu_hotplug_lock.rw_sem/mem_hotplug_lock.rw_sem —> kn->count

Right. Memcg runs this function at cgroup creation time. sysfs
initialization was designed to run a at boot. So the sysfs initialization
needs a rewrite of its serialization for the memcg case. We cannot loop
over the list of all kmem caches holding the slab_mutex anymore.

--531401748-1172478698-1576002757=:14347--
