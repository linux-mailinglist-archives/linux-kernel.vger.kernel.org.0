Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50D16FAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 10:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBZJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 04:36:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:34586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbgBZJgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:36:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 337A1AC66;
        Wed, 26 Feb 2020 09:36:21 +0000 (UTC)
Date:   Wed, 26 Feb 2020 09:36:26 +0000
From:   Luis Henriques <lhenriques@suse.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ceph: re-org copy_file_range and fix some error paths
Message-ID: <20200226093626.GA15815@suse.com>
References: <20200224134432.25888-1-lhenriques@suse.com>
 <c406ee08db90c1452c4ba9740b046ca9204c7239.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c406ee08db90c1452c4ba9740b046ca9204c7239.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 02:15:12PM -0800, Jeff Layton wrote:
... 
> This looks good to me, Luis -- merged into ceph-client/testing.

Awesome, thanks!  Please let me know of any issues you may find.

Cheers,
--
Lu�s
