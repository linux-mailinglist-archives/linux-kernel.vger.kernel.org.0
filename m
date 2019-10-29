Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29FE7E79
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 03:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfJ2COV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 22:14:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:11033 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbfJ2COV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 22:14:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 19:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,242,1569308400"; 
   d="scan'208";a="205342149"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 19:14:20 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0198C301C0F; Mon, 28 Oct 2019 19:14:19 -0700 (PDT)
Date:   Mon, 28 Oct 2019 19:14:19 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, eranian@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] perf pmu: Use file system cache to optimize sysfs
 access
Message-ID: <20191029021419.GT4660@tassilo.jf.intel.com>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-2-andi@firstfloor.org>
 <20191028220137.GF28772@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028220137.GF28772@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:01:37PM +0100, Jiri Olsa wrote:
> On Fri, Oct 25, 2019 at 11:14:11AM -0700, Andi Kleen wrote:
> 
> SNIP
> 
> >  	if (pmu_aliases_parse(path, head))
> >  		return -1;
> > @@ -525,7 +524,6 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
> >   */
> >  static int pmu_type(const char *name, __u32 *type)
> >  {
> > -	struct stat st;
> >  	char path[PATH_MAX];
> >  	FILE *file;
> >  	int ret = 0;
> > @@ -537,7 +535,7 @@ static int pmu_type(const char *name, __u32 *type)
> >  	snprintf(path, PATH_MAX,
> >  		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/type", sysfs, name);
> >  
> > -	if (stat(path, &st) < 0)
> > +	if (access(path, R_OK) < 0)
> 
> why not file_available call in here?

iirc it doesn't do any redundant accesses.

-Andi

