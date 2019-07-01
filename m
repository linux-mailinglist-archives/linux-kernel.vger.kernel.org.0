Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1C27A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfEWKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:10:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:15994 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbfEWKKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:10:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP; 23 May 2019 03:10:07 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2019 03:10:05 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 0/8] docs: Fixes for recent versions of Sphinx
In-Reply-To: <20190523093944.mylk5l3ginkpelfi@butterfly.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190522205034.25724-1-corbet@lwn.net> <20190523093944.mylk5l3ginkpelfi@butterfly.localdomain>
Date:   Thu, 23 May 2019 13:13:23 +0300
Message-ID: <877eah7a2k.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019, Oleksandr Natalenko <oleksandr@redhat.com> wrote:
> Thanks for the efforts. I've run this on top of Linus' tree, and the
> only sphinx-related deprecation warning I've spotted is this one:
>
> /home/onatalen/work/src/linux/Documentation/sphinx/cdomain.py:51: RemovedInSphinx30Warning: app.override_domain() is deprecated. Use app.add_domain() with override option instead.
>   app.override_domain(CDomain)
>
> Otherwise, it builds.

Please share your Sphinx version (sphinx-build --version).

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
