Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5358ECEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 15:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbfHONeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 09:34:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:16788 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731747AbfHONeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:34:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 06:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="194766618"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 15 Aug 2019 06:33:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 15 Aug 2019 16:33:58 +0300
Date:   Thu, 15 Aug 2019 16:33:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] software node: Add software_node_find_by_name()
Message-ID: <20190815133358.GC24772@kuha.fi.intel.com>
References: <20190815112826.81785-1-heikki.krogerus@linux.intel.com>
 <20190815112826.81785-2-heikki.krogerus@linux.intel.com>
 <CAHp75VduJ2VQ-4r-vrARMyL6WAnsppwMtLRD-g4f-GEnew8m2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VduJ2VQ-4r-vrARMyL6WAnsppwMtLRD-g4f-GEnew8m2g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:55:40PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 15, 2019 at 2:32 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Function that searches software nodes by node name.
> 
> > +/**
> > + * software_node_find_by_name - Find software node by name
> > + * @parent: Parent of the software node
> > + * @name: Name of the software node
> > + *
> > + * The function will find a node that is child of @parent and that is named
> > + * @name. If no node is found, the function returns NULL.
> 
> Shouldn't we add that the caller responsible of putting kobject?

OK. I'll fix this and the other one too.

Thanks Andy!

-- 
heikki
