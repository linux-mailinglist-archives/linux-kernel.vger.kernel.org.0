Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234011CD07
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfENQct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 12:32:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:55236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfENQct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:32:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D67C7AEF3;
        Tue, 14 May 2019 16:32:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A58ADA866; Tue, 14 May 2019 18:33:48 +0200 (CEST)
Date:   Tue, 14 May 2019 18:33:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Can crypto API provide information about hw acceleration?
Message-ID: <20190514163348.GM3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Q: is there a way to query the crypto layer whether a given algorithm
(digest, crypto) is accelerated by the driver?

This information can be used to decide if eg. a checksum should can be
calculated right away or offloaded to a thread. This is done in btrfs,
(fs/btrfs/disk-io.c:check_async_write).

At this moment it contains a static check for a cpu feature, and only
for x86. I briefly searched the arch/ directory for implementations of
crc32c that possibly use hw aid and there are several of them. Adding a
static check a-la x86 for the other architectures (arm, ppc, mips,
sparc, s390) is wrong, so I'm looking for a clean solution.

The struct shash_alg definition of the algorithms does not say anything
about the acceleration. The closest thing is the cra_priority, but I
don't know if this is reliable information. The default implementations
seem to have 100, and acceleated 200 or 300.

This would be probably sufficient, but I'd like a confirmation from
crypto people.

Thanks.
