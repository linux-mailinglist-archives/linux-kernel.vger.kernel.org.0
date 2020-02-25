Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F2C16BE06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 10:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgBYJ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 04:56:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:23664 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBYJ4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:56:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 01:56:09 -0800
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="230968346"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 01:56:04 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, mripard@kernel.org, mihail.atanassov@arm.com
Cc:     pankaj.laxminarayan.bharadiya@intel.com,
        linux-kernel@vger.kernel.org, ankit.k.nautiyal@intel.com
Subject: Re: [RFC][PATCH 1/5] drm: Introduce scaling filter property
In-Reply-To: <20200225070545.4482-2-pankaj.laxminarayan.bharadiya@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com> <20200225070545.4482-2-pankaj.laxminarayan.bharadiya@intel.com>
Date:   Tue, 25 Feb 2020 11:56:01 +0200
Message-ID: <87pne3rnwu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com> wrote:
> Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@intel.com>
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

What did Shashank and Ankit do, should one or the other perhaps retain
authorship?

In any case, when taking over code and submitting, you should add your
sign-off *last*. Please see [1] for what Signed-off-by means.

BR,
Jani.


[1] https://developercertificate.org/

-- 
Jani Nikula, Intel Open Source Graphics Center
