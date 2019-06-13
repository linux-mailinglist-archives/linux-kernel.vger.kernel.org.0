Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B564443BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfFMPbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:31:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfFMPbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f/0g5Z9NCQMhWfThA5zJkOmPa2ERnbPBpaXYsJjVOvs=; b=rrUSOFkA3S2in8Oua2Q2eIa5p
        6vhNTVYFFi/ghkWdgxaCW0yJp0jbeyCulDj+Nn+PUaRBMr5xamODS2KwatiQV94wvOAyx3eXbN6Rj
        ZaMWu1gO/mRtKncIIT45SX0x4ifL7b7W4wWa2kRkcN7oTJOm9FZC+sTjzvQd8JBYwByl1A9YcXAjq
        GKTcXlQklPDdbSO1giVKuIfu+HyxDIQrX5SnMNAMSj+2u5vnKQEW315RLfzh/6t++MYIPh6MSCFgf
        +Ka/ICJfh2gvI3eTBnvav7r2GMPVXweED7fJ9HpNfXBNOmkAlYDQTI+7/2WorUMzc4iZYm08fcm32
        9mXFyZ4ig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hbRhW-0004n9-0S; Thu, 13 Jun 2019 15:31:42 +0000
Date:   Thu, 13 Jun 2019 08:31:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/vmalloc: Check absolute error return from
 vmap_[p4d|pud|pmd|pte]_range()
Message-ID: <20190613153141.GJ32656@bombadil.infradead.org>
References: <1560413551-17460-1-git-send-email-anshuman.khandual@arm.com>
 <7cc6a46c50c2008bfb968c5e48af5a49@suse.de>
 <406afc57-5a77-a77c-7f71-df1e6837dae1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406afc57-5a77-a77c-7f71-df1e6837dae1@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 08:51:17PM +0530, Anshuman Khandual wrote:
> acceptable ? What we have currently is wrong where vmap_pmd_range() could
> just wrap EBUSY as ENOMEM and send up the call chain.

It's not wrong.  We do it in lots of places.  Unless there's a caller
which really needs to know the difference, it's often better than
returning the "real error".
