Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12EA167EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 14:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgBUNoY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Feb 2020 08:44:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:43462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgBUNoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:44:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F892B137;
        Fri, 21 Feb 2020 13:44:23 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Joe Perches <joe@perches.com>, Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [trivial PATCH] cifs: Use #define in cifs_dbg
In-Reply-To: <862518f826b35cd010a2e46f64f6f4cfa0d44582.camel@perches.com>
References: <862518f826b35cd010a2e46f64f6f4cfa0d44582.camel@perches.com>
Date:   Fri, 21 Feb 2020 14:44:21 +0100
Message-ID: <87eeuo5a2y.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:
> +			cifs_dbg(VFS, "bogus file nlink value %u\n",
> +				 fattr->cf_nlink);

Good catch :)
I realize that 1 is VFS but this should probably be FYI.

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
