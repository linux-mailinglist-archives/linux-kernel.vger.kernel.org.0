Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0C20D94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 19:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfEPRAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 13:00:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:44620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfEPRAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:00:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3E93AD0A;
        Thu, 16 May 2019 17:00:36 +0000 (UTC)
Date:   Thu, 16 May 2019 19:00:35 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     mkoutny@suse.cz, linux-mm@kvack.org, akpm@linux-foundation.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: mm: use down_read_killable for locking mmap_sem in
 access_remote_vm
Message-ID: <20190516170034.GO13687@blackbody.suse.cz>
References: <20190515083825.GJ13687@blackbody.suse.cz>
 <11ee83c8-5f0f-0950-a588-037bdcf9084e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11ee83c8-5f0f-0950-a588-037bdcf9084e@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, May 15, 2019 at 11:48:32AM +0300, Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> This function ignores any error like reading from unmapped area and
> returns only size of successful transfer. It never returned any error codes.
This is a point I missed. Hence no need to adjust consumers of
__access_remote_vm() (they won't actually handle -EINTR correctly w/out
further changes). This beats my original idea with simplicity.


Reviewed-by: Michal Koutn� <mkoutny@suse.com>

Michal

