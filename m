Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5984EB55
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFUO6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 10:58:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3dT8GgJ6+uQhH34e10+L7yEjvR1H493y6W8QxwGRYS0=; b=IciHtC1ApoWbUNoHP8hTutDrf
        o6gvUQ24Xt0J/bDrghCwt4cTzS188eaW79VxqY0BfbMmSloZAPNz+SSJ7lJwC1At/wwBlNnZMzGvE
        JI3kRdeSfQRJnLw93aYTxtNxEc88pjz1eFuKSrVFWWA9dYgBW3S2QHuF89ixFNoxdmCFa9evNZ71l
        bLbOKkFnBVE60MYg64lKrVu1HfeUjrlQHjDW2nCQQY0aK/NepvOgeU05EzOnC3ZAMsFFqVOTx03B9
        7rOmUhzubu7OkflA1YJR2Y2vXrp4aWmkmQskIwoNoAvTG4qZ/L9tz9pGkLltxg3c60n84ssoMa0Mi
        yBJMlDyDA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1heKzO-0002EK-KP; Fri, 21 Jun 2019 14:58:06 +0000
Date:   Fri, 21 Jun 2019 07:58:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sparsemem: Cleanup 'section number' data types
Message-ID: <20190621145805.GN32656@bombadil.infradead.org>
References: <156107543656.1329419.11505835211949439815.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156107543656.1329419.11505835211949439815.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 05:06:46PM -0700, Dan Williams wrote:
> David points out that there is a mixture of 'int' and 'unsigned long'
> usage for section number data types. Update the memory hotplug path to
> use 'unsigned long' consistently for section numbers.

... because we're seriously considering the possibility that we'll need
more than 4 billion sections?
