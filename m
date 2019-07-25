Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75E275875
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfGYT5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 15:57:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38583 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfGYT5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:57:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id f5so14731598pgu.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=z3gfabpCWUVaGAUSw0MxCoyTFf/o84kvoKmk3SIMZvA=;
        b=K2gtNxpcP3C/BgmzOANgjBnuKx5KSsCbq7QzQltttoKuFeZ0em5jBbDKng2lPJ/WYW
         ISjRcGhFIKq/2BkW4+uBt3yK7wFtMuG7w52gbRMuo9KVzxP9MmUAnVEYpiAurBhS/mA5
         zDy74FjHoiuSLMDMdOw1UeqqYdUNPoHuq4PdKkGx7H6poyLpNEgyuxHdM4kE6MgvJpSt
         Fic4XLXvGB+PpyCXQV25ENxp7x715QdczjG+a7l295x3U+NTvzm8m75i/ORfjSfUwtWH
         4hF1UAOq+UYSWpdkjgjKalpnpLSku/ktz80r1nK6eo4Ue2blX1THfIlJg0gS/X3exbtK
         q/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=z3gfabpCWUVaGAUSw0MxCoyTFf/o84kvoKmk3SIMZvA=;
        b=KdMyQeqJDhPymSNhpfiNES9M5u0ZixHC31nyHwhCkGKZmg3sMiD2hiW1lagp3yzJQj
         LiSyYTweJIKHOpm7WYkS9nOWAOPGwedq9o1h6UG+SJV2udYfk8jcLc46utwYMVXypzhP
         EP8GqcM5nDhaPHb9wYheiCpKJ7xuFsOVUtfaFcwcnakBs0OZ7fLluUJkHgsZeqFha63n
         4yyT+MerigDGDpJ7JMEieEa2aDkkaLCK8eVr0uENM2u70UFyxF6fqKHrTYzesNOXOYiR
         X7+gXjhv3r18d+6HO+1sUv6Nc0yXzTd+uFS/tdLrPG0/wvQHrmomORyfBI2U4Qrsla+4
         pkxg==
X-Gm-Message-State: APjAAAXDD38/MJClLNMf4UwxXcXVK+YVX8/gqHo8iNPz1lzos8HTSWnH
        eNOATsBs87pEnIHL7UUTr3M=
X-Google-Smtp-Source: APXvYqwYaMiTEGEtbwKQafsmqY9x5kvnOWkZbNXQJl6iHr/oj4El5MucyK05NulANRdNAcxCwG9Ajg==
X-Received: by 2002:a17:90a:cb97:: with SMTP id a23mr92544764pju.67.1564084660336;
        Thu, 25 Jul 2019 12:57:40 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id s12sm51165811pgr.79.2019.07.25.12.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:57:39 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F7AD868F-D88A-49BC-8E7C-0E2A7416695A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5609791F-2055-446D-B1FA-F1348E9ACB53";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Fix deadlock on page reclaim
Date:   Thu, 25 Jul 2019 13:57:36 -0600
In-Reply-To: <20190725115442.GA15733@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_5609791F-2055-446D-B1FA-F1348E9ACB53
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jul 25, 2019, at 5:54 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Thu, Jul 25, 2019 at 06:33:58PM +0900, Damien Le Moal wrote:
>> +	gfp_t gfp_mask;
>> +
>> 	switch (ext4_inode_journal_mode(inode)) {
>> 	case EXT4_INODE_ORDERED_DATA_MODE:
>> 	case EXT4_INODE_WRITEBACK_DATA_MODE:
>> @@ -4019,6 +4019,14 @@ void ext4_set_aops(struct inode *inode)
>> 		inode->i_mapping->a_ops = &ext4_da_aops;
>> 	else
>> 		inode->i_mapping->a_ops = &ext4_aops;
>> +
>> +	/*
>> +	 * Ensure all page cache allocations are done from GFP_NOFS context to
>> +	 * prevent direct reclaim recursion back into the filesystem and blowing
>> +	 * stacks or deadlocking.
>> +	 */
>> +	gfp_mask = mapping_gfp_mask(inode->i_mapping);
>> +	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));
> 
> This looks like something that could hit every file systems, so
> shouldn't we fix this in common code?

It also has the drawback that it prevents __GFP_FS reclaim when ext4
is *not* at the bottom of the IO stack.

> We could also look into just using memalloc_nofs_save for the page
> cache allocation path instead of the per-mapping gfp_mask.

That makes more sense.

Cheers, Andreas






--Apple-Mail=_5609791F-2055-446D-B1FA-F1348E9ACB53
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl06CbAACgkQcqXauRfM
H+Cc4RAAwDIi92Jq5bJgWNXpycrtCx0w4VV1jgbWb0fohPV0RRgmI1OYmfN4y2nq
7Qlp7dmpJpPphqkGmPIEfapybg18Vdv2ZYI6kWr66EME7PXsRO8MpGTNznx9C68Z
tWRnIxQcmZGKRDX208oWaHazar7dPtE5CIzYvn9tIr6rORYuyZ9dpKMddBlEMI2V
+ZDUqRgS1lI+BEbeMXD+/oyVUykaGlR0JnkJhzIylkHGRfbzpKaKfxfNgY37Cccv
En+GiMLzu/2W3L7si95fqEKu/OGFmiKLfDZg0OfhfZUIwNrbief7pemmsfA9XaZH
sqloaIYVTtLo4pzU7Hmc4eBzsHHMxQjtQFv0jVXQYljzJK8fDsl016Mg6Z+ZB5YK
HGafAYK391Mi+1x68SndtIloIf+PJV9EJljieeyPQgF1x9PtQdqIfBmLSwPV0Uo9
0eFhEBcF96xIsLrMnN1bThGDRTzM9i7kfHCEVlu/3VTLeG9ml1C93jbujh9zbwqy
rhxt6FmzV03KBAoMgVJrdyK+B49WVIPeI0xXOVKGGJATK7qutC+Nu1qy808mSvmS
QIbXEPqRzAuIAb8pRPdje+59BBUmDDvT4lhBdlNTLrxqpzLm+ClSbIMBSOg/pKET
LE7e+ZTsQzx0ZitVjjf7DO8In9CoTzhexgwrUT3gP7dwIFpS+2M=
=9Xt0
-----END PGP SIGNATURE-----

--Apple-Mail=_5609791F-2055-446D-B1FA-F1348E9ACB53--
