Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77696E4F41
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439900AbfJYOgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 10:36:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39625 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfJYOgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:36:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id p12so1669720pgn.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uSPdUapM/onU7pr2pFxl/VWrfdFwoNbPnlO91BNIhwc=;
        b=K2/17chtnI4QrJz69iyMG9kAbGNolE1Ypw+xTe9KXIrKFc1IJts1cwr+izyorjGAPi
         eoKSCKqiV8sKRXpyjG3fvzCtZ8ZcEkgB/MWwLZM3z+YmpSk5pGRQikF/T5ER6mC2FvoK
         aCaRDw1nqlkj1pu9TVZf66gRtTgFNnaiGQNLW0VM7meaJpOjuP1m2N1ghZ2FYm9dicQp
         XgNFzBZxLcf/g1i9SPRELk8bmBQ8/EhsLd1bmxvJ9SVZ7j0Ji+zvawm0aIQ5/lf0e1t0
         odS1DciibHv84fIaek+jzn6wycldwS7r1Y7q/1GqP0RTh73HQaNPgshpQFlrZI0D1LyT
         nXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uSPdUapM/onU7pr2pFxl/VWrfdFwoNbPnlO91BNIhwc=;
        b=g6M92A2D0eUzfXFfsAycpYMPh/lETieNyQxUQP1yBWkxOsmPursDsIuHhJdOkCmhGn
         3+bnVYGifsPvDRWD6Zr30kjG/SihZItrl3ZywbRDPQABAynq2kcJLKtGWcTmDx6s8egf
         3O6x/jWhGX6LZVeoNSS/+EHzGqEoTTrM2apCNYch49LuRSfBHTB/kUK+6ndep900mypp
         oLgO7pEnIwCZg0uf25aC+BMR3BuG6aNLio1m183FWTDf2auUJq9ICdlzMZEWS/tKwDZf
         2J347PSxyXQGX33Qz/nvjZQX7fLUS4ACPcqvsRTbwp7Wc+6k0K1hPynvEHJyKtprH/yT
         tfpw==
X-Gm-Message-State: APjAAAW4XZwJaNJ4NH+xfc7PIsCEgV8rwA5bUvZSmAELqV777J/Z0cRK
        gmrwzEvXUMLVzfp4QsPGQ0fXvg==
X-Google-Smtp-Source: APXvYqzBIOR7+zqupTUOwakr1aSv4Yqgu48d300ZL0HkC7jsA8xSczu31emS6h4igmCBJW7NNr0+JQ==
X-Received: by 2002:a62:3441:: with SMTP id b62mr4611736pfa.12.1572014203305;
        Fri, 25 Oct 2019 07:36:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::553e])
        by smtp.gmail.com with ESMTPSA id b192sm2447972pga.59.2019.10.25.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:36:42 -0700 (PDT)
Date:   Fri, 25 Oct 2019 10:36:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 7/8] mm: vmscan: split shrink_node() into node part and
 memcgs part
Message-ID: <20191025143640.GA386981@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-8-hannes@cmpxchg.org>
 <20191022200819.GC22721@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022200819.GC22721@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 08:08:23PM +0000, Roman Gushchin wrote:
> On Tue, Oct 22, 2019 at 10:48:02AM -0400, Johannes Weiner wrote:
> > This function is getting long and unwieldy, split out the memcg bits.
> > 
> > The updated shrink_node() handles the generic (node) reclaim aspects:
> >   - global vmpressure notifications
> >   - writeback and congestion throttling
> >   - reclaim/compaction management
> >   - kswapd giving up on unreclaimable nodes
> > 
> > It then calls a new shrink_node_memcgs() which handles cgroup specifics:
> >   - the cgroup tree traversal
> >   - memory.low considerations
> >   - per-cgroup slab shrinking callbacks
> >   - per-cgroup vmpressure notifications
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/vmscan.c | 28 ++++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index db073b40c432..65baa89740dd 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2722,18 +2722,10 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
> >  		(memcg && memcg_congested(pgdat, memcg));
> >  }
> >  
> > -static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > +static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >  {
> > -	struct reclaim_state *reclaim_state = current->reclaim_state;
> >  	struct mem_cgroup *root = sc->target_mem_cgroup;
> > -	unsigned long nr_reclaimed, nr_scanned;
> > -	bool reclaimable = false;
> >  	struct mem_cgroup *memcg;
> > -again:
> > -	memset(&sc->nr, 0, sizeof(sc->nr));
> > -
> > -	nr_reclaimed = sc->nr_reclaimed;
> > -	nr_scanned = sc->nr_scanned;
> >  
> >  	memcg = mem_cgroup_iter(root, NULL, NULL);
> >  	do {
> > @@ -2786,6 +2778,22 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  			   sc->nr_reclaimed - reclaimed);
> >  
> >  	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
> > +}
> > +
> > +static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > +{
> > +	struct reclaim_state *reclaim_state = current->reclaim_state;
> > +	struct mem_cgroup *root = sc->target_mem_cgroup;
> > +	unsigned long nr_reclaimed, nr_scanned;
> > +	bool reclaimable = false;
> > +
> > +again:
> > +	memset(&sc->nr, 0, sizeof(sc->nr));
> > +
> > +	nr_reclaimed = sc->nr_reclaimed;
> > +	nr_scanned = sc->nr_scanned;
> > +
> > +	shrink_node_memcgs(pgdat, sc);
> >  
> >  	if (reclaim_state) {
> >  		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> > @@ -2793,7 +2801,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  	}
> >  
> >  	/* Record the subtree's reclaim efficiency */
> > -	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> > +	vmpressure(sc->gfp_mask, root, true,
> 
> Maybe target? Or target_memcg? The word root is associated with the root cgroup.
>
> Other than root the patch looks good to me:
> 
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!

I agree, target_memcg is better than root. The next patch also
replaces some of these with target_lruvec.

This on top?

From f981c99d3a9da05513c5137873315974782e97ec Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 25 Oct 2019 10:28:42 -0400
Subject: [PATCH] mm: vmscan: split shrink_node() into node part and
 memcgs part fix

As per Roman's suggestion, rename "root" to "target_memcg" to avoid
confusion with the global cgroup root, root_mem_cgroup.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 65baa89740dd..6199692af434 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2724,16 +2724,16 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
 
 static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 {
-	struct mem_cgroup *root = sc->target_mem_cgroup;
+	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
 	struct mem_cgroup *memcg;
 
-	memcg = mem_cgroup_iter(root, NULL, NULL);
+	memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long reclaimed;
 		unsigned long scanned;
 
-		switch (mem_cgroup_protected(root, memcg)) {
+		switch (mem_cgroup_protected(target_memcg, memcg)) {
 		case MEMCG_PROT_MIN:
 			/*
 			 * Hard protection.
@@ -2777,13 +2777,13 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			   sc->nr_scanned - scanned,
 			   sc->nr_reclaimed - reclaimed);
 
-	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
+	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
 }
 
 static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct reclaim_state *reclaim_state = current->reclaim_state;
-	struct mem_cgroup *root = sc->target_mem_cgroup;
+	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
 	unsigned long nr_reclaimed, nr_scanned;
 	bool reclaimable = false;
 
@@ -2801,7 +2801,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	}
 
 	/* Record the subtree's reclaim efficiency */
-	vmpressure(sc->gfp_mask, root, true,
+	vmpressure(sc->gfp_mask, target_memcg, true,
 		   sc->nr_scanned - nr_scanned,
 		   sc->nr_reclaimed - nr_reclaimed);
 
@@ -2857,7 +2857,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 */
 	if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
 	    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
-		set_memcg_congestion(pgdat, root, true);
+		set_memcg_congestion(pgdat, target_memcg, true);
 
 	/*
 	 * Stall direct reclaim for IO completions if underlying BDIs
@@ -2866,7 +2866,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * the LRU too quickly.
 	 */
 	if (!sc->hibernation_mode && !current_is_kswapd() &&
-	    current_may_throttle() && pgdat_memcg_congested(pgdat, root))
+	    current_may_throttle() &&
+	    pgdat_memcg_congested(pgdat, target_memcg))
 		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
-- 
2.23.0

