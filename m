Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAB16BD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgBYJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 04:16:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:62006 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgBYJQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:16:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 01:15:59 -0800
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="230960445"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 01:15:54 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: changes.rst: Escape --version to fix Sphinx output
In-Reply-To: <20200224211044.GQ24185@bombadil.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200223222228.27089-1-j.neuschaefer@gmx.net> <20200224110815.6f7561d1@lwn.net> <20200224184719.GA2363@latitude> <20200224185227.GO24185@bombadil.infradead.org> <20200224115851.6684d516@lwn.net> <20200224191248.GP24185@bombadil.infradead.org> <e31ce703-c88b-7901-60a7-62fd5e78a1e0@infradead.org> <20200224211044.GQ24185@bombadil.infradead.org>
Date:   Tue, 25 Feb 2020 11:15:51 +0200
Message-ID: <87v9nvrprs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Feb 24, 2020 at 01:08:13PM -0800, Randy Dunlap wrote:
>> Not trying to be contrary, but I would prefer to keep .rst files as much
>> ASCII as possible.
>
> I don't think anybody is arguing otherwise.  The question is whether
> minusminus should be left as a pair of minus signs or whether it should
> be converted into an en-dash.

FWIW I think a pair of minus signs is never completely wrong in the
output (even when the semantics is en-dash and the conversion is
desirable) but occasionally converting a pair of minus signs to en-dash
is incorrect. Thus retaining the "smart" conversion requires we use some
form of escaping when we don't want double minus to be converted to
en-dash. I'd lean towards "smartquotes = False".

It'll still possible to add Unicode en-dash directly in the .rst if
people really want that.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
