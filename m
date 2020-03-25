Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A46193125
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 20:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCYT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 15:29:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgCYT3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:29:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4E070AC65;
        Wed, 25 Mar 2020 19:29:49 +0000 (UTC)
Date:   Wed, 25 Mar 2020 12:29:44 -0700
From:   Tony Jones <tonyj@suse.de>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space
 unwinding
Message-ID: <20200325192944.GI27749@suse.de>
References: <20200325164053.10177-1-tonyj@suse.de>
 <20200325191757.GG14102@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325191757.GG14102@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 04:17:57PM -0300, Arnaldo Carvalho de Melo wrote:

> > As an aside, for record path, do you know where PERF_SAMPLE_CALLCHAIN
> > is actually set before being passed to kernel space?
> 
> So, I think is somewhere down from perf_evsel__config()... its in:
> 
> 	perf_evsel__set_sample_bit(evsel, CALLCHAIN);

Thanks for the pointer. I was having a hard time finding it, being too specific.

Tony
