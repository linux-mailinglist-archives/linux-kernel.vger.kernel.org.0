Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022BA1B3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 12:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfEMKNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 06:13:48 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:35600 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfEMKNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:13:47 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 6BDA2202D3;
        Mon, 13 May 2019 12:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1557742420; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5mgh4KCp63jsksPf9LEb/AYezgTUIq/azbAEZv5xKE=;
        b=KlhpbFtMT08WmEzekabJJrNbF0LR2M+P3ImvaqOsqMLfInyF0CAv7a5CaDN4nMLcKqpfQW
        kF0rf5m6UGFheax/OWvvGwQSWrsQQAOds5NNpeIdKhiL4YLdcxj4PUoh3dFuS/ZDzx5dws
        ZZtoPp8nlzU43Fq9gJDMLrP9Omel3Za6CibOdwRIio2GXJqmcR5MHYeGHArc0eBbb0AJGn
        UxE4VILzpGilsG6EMyjwKrhhi18JXRYJJSM3qtvMGmRQdxW8EUXJ/ehPnBRYnG5ueIWKyN
        AFF3WZ6GZvCnyRoMGp4BhEXqiFJmFdFKTpia0GEgijVVCY9jvT21KXIEcBlAkg==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 12F82BEEBD;
        Mon, 13 May 2019 12:13:40 +0200 (CEST)
Message-ID: <5CD94353.90702@bfs.de>
Date:   Mon, 13 May 2019 12:13:39 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     David Howells <dhowells@redhat.com>
CC:     jaltman@auristor.com, linux-afs@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] afs: Fix afs_xattr_get_yfs() to not try freeing an
 error value
References: <5CD8697B.6010004@bfs.de> <5CD844B0.5060206@bfs.de> <155764714099.24080.1233326575922058381.stgit@warthog.procyon.org.uk> <155764714872.24080.15171754166782593095.stgit@warthog.procyon.org.uk> <31808.1557684645@warthog.procyon.org.uk> <6819.1557691584@warthog.procyon.org.uk>
In-Reply-To: <6819.1557691584@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.08
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.08 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-2.98)[99.91%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 12.05.2019 22:06, schrieb David Howells:
> walter harms <wharms@bfs.de> wrote:
> 
>> Sorry, you misunderstood me, my fault, i did not see that size is unsigned.
>> NTL i do not think size=0 is useful.
> 
> Allow me to quote from the getxattr manpage:
> 
>        If size is specified as zero, these calls return the  current  size  of
>        the  named extended attribute (and leave value unchanged).  This can be
>        used to determine the size of the buffer that should be supplied  in  a
>        subsequent  call.   [...]
>  
ok, sorry for the noise i did not know, for me that look unintended.



>> while you are there:
>>   flags |= YFS_ACL_WANT_ACL is always flags = YFS_ACL_WANT_ACL;
>> since flags is 0 at this point.
>> IMHO that sould be moved to the strcmp() section.
> 
> Why?  It makes the strcmp() section more complicated and means I now either
> have to cache flags in a variable or do the allocation of yacl first.
> 

no need to cache, the idea was only to make the correlation between the name
and flags more obvious. (no need to hurry, i just noticed it)

if (strcmp(name, "acl") == 0) {
		which = 0;
                flags = YFS_ACL_WANT_ACL;
	}
else if (strcmp(name, "acl_inherited") == 0) {
		which = 1;
                flags = 0;
        }
else if (strcmp(name, "acl_num_cleaned") == 0) {
		which = 2;
                flags = 0;
	}
else if (strcmp(name, "vol_acl") == 0) {
		which = 3;
                flags = YFS_ACL_WANT_VOL_ACL;
}
....

re,
 wh
> David
> 
