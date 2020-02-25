Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0816BF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 12:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgBYLID convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Feb 2020 06:08:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:28382 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbgBYLID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:08:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 03:08:03 -0800
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="230984756"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 03:07:58 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Laxminarayan Bharadiya\, Pankaj" 
        <pankaj.laxminarayan.bharadiya@intel.com>,
        "daniel\@ffwll.ch" <daniel@ffwll.ch>,
        "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "ville.syrjala\@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "airlied\@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst\@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "tzimmermann\@suse.de" <tzimmermann@suse.de>,
        "mripard\@kernel.org" <mripard@kernel.org>,
        "mihail.atanassov\@arm.com" <mihail.atanassov@arm.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nautiyal\, Ankit K" <ankit.k.nautiyal@intel.com>
Subject: RE: [RFC][PATCH 1/5] drm: Introduce scaling filter property
In-Reply-To: <E92BA18FDE0A5B43B7B3DA7FCA03128605773303@BGSMSX107.gar.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com> <20200225070545.4482-2-pankaj.laxminarayan.bharadiya@intel.com> <87pne3rnwu.fsf@intel.com> <E92BA18FDE0A5B43B7B3DA7FCA03128605773303@BGSMSX107.gar.corp.intel.com>
Date:   Tue, 25 Feb 2020 13:07:55 +0200
Message-ID: <87mu96sz5g.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020, "Laxminarayan Bharadiya, Pankaj"	<pankaj.laxminarayan.bharadiya@intel.com> wrote:
>> On Tue, 25 Feb 2020, Pankaj Bharadiya
>> <pankaj.laxminarayan.bharadiya@intel.com> wrote:
>> > Signed-off-by: Pankaj Bharadiya
>> > <pankaj.laxminarayan.bharadiya@intel.com>
>> > Signed-off-by: Shashank Sharma <shashank.sharma@intel.com>
>> > Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> 
>> What did Shashank and Ankit do, should one or the other perhaps retain
>> authorship?
>
> I kind of refactored the code, added plane scaling support added new
> APIs & documentation and rewrote the scaling filter setting
> logic. Since I made significant changes (IMHO), I thought of changing
> the authorship. I spoke with Ankit regarding this during my initial
> discussion with him.
>
> Will you please review the present RFC and the older one and suggest.  I have
> no issues with changing the authorship 😊.

It's fine with me if it's fine with Ankit. Thanks for checking.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
