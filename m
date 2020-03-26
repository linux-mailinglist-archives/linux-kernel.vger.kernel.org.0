Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3E193FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 14:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCZNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 09:31:02 -0400
Received: from mout.web.de ([212.227.15.14]:49247 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgCZNbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585229416;
        bh=x5/lFZNctb5V891a5Jq8s3QenA2mRr4ckpxoafDBOPc=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=h2xq/4o3/nLvCo4vjdNgmEKHMl96IIpVUFvIdatQL3FjTp/mLlwYRRVtMJ5bSCFSe
         Cp3X9Fay3GwryGQxPZkpAoDCjynTXGdy9GU7TbG8MI4c7nXUfU0faQY3D2JbsyH9CT
         YzmNFmWDILQGCSvrDAFozCG7ZolVJAuzAoyxDJ6E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.12.165]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNLAn-1jB94A3Jiz-006uLj; Thu, 26
 Mar 2020 14:30:15 +0100
To:     Michel Lespinasse <walken@google.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ying Han <yinghan@google.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/8] mmap locking API: use coccinelle to convert mmap_sem
 rwsem call sites
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b1c878c0-878a-6684-7cac-d1f4409295f6@web.de>
Date:   Thu, 26 Mar 2020 14:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:LlYn7ffpAZeb1dm0RjuYPINEpd0abqAOrUM4Ms9HdTGNVlJcA/n
 +R3F8gjx8ArM1IcDr2ctZ/wn5yj71qINIrVlyU+QVslWddmTyMpRMFhocKLvfVsk/JxvCkC
 MRTvnsr+uQ72rPwB9kM1K6kK03F98wNr3cTvOssk3PnevJiMuBmOqfgwQV+Ro1FftwjA0gX
 a20u+4DgP6yUu6ae2Y69w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nSda4I9tB08=:vFuU4oJLb6zarBeTEGsJ98
 XfuK8JA1KQshGuh6FZxK6ub3uCJtwZsW+cA3c/pINQ28fGtPzAENH34wDZRCmsd26kzTby5Eo
 OzgBzDDwP464sfWz41bltXDpJzSUfMBn6bJm2ryIBMgNWGE4TxeAFbQeGCnM+iw/MbcoMNkOK
 rXSvWLMibMSiyTLvzFnmkpmbERzQkQQsC3CT/vhmN+BWXAGMCU0T4Z7OzdeaPxPYT/bk0et/T
 tW0oa9oMbPnTodvtwqMmxuPMdu7oPycev6P1m4o/ESMOsSOr5z9RmRvHJH2WMzFBiH5dh7/FG
 MPVKlvq+rnRfCaDkJ+KcJqXLoNykI1ag90fIRdRj88MKxk+e+koiLAGYoC5hkr44oipKQEsR2
 U+R2xAbtgjSwR6sbSyVDU235/OVJDIzXK+hdP2SQxz+DJCkKZyq8kJBOmDo0KlBewK17pZOFZ
 iJWQ6c+BlTln3lrHJqquLStIkuEC3zCn2bKFfTOs8HckicX2AB0LkP6UyfRa4w0y61HIGlInS
 cqX1r+QgntZemBLUDzBoxbkTh2msRRkYg3WxNOOI91C904YM3qdUrqz/biVxssa2taA4r4IWI
 LwnzjquPJSof4183lzm0vJHTKOazNkF5LuF5VliK1GX57Y15Iy1+VVRRaMx9/UYvNBus2X8+S
 A7pLMJXtSb+nf06b2LhkAsn4+6tWmfNFO4ceP+rT2rnu75SyoBLDJTcq5YQl4aIb6S/agExyI
 2kzHMejh6xbBsR4OD9LRkT7HOPWvwl1KdRVGXARF+M2X0RkMzwC1xgGRveJdAVhDlCNxg03/K
 Y1y6dwMmBoQe+RIImfMgqP53FoQHFdbjPBYseZNFLWVpxho3sw5+jnGbAYJiplfBdXgEDAoHc
 4lcDZg3fGYyr0oBtMwT0gxqY69ACHdQ+dcphODOX9betqcFtkUCHLlY+NjcVVRpgF9tYxkBt8
 5dUIjmRs4z2DpvktVP7vquBMc0v4VgxnCtr5KayoD5E//JpY033fmaJX6R99ja1XUcSl5sJc3
 eLBFuEg2L1FMFRN9oT4Sr30Ig2agp0Rsb/ThC529VsXFZSxBqsbq/uoTJvn12FQVkYxn7nXi3
 DFjrlzTEj6ZrMNSybWp72ZLam07IHpZ4CTbdQQgGuDV29LoJ1GtmL8G5wTrLkPR26KXLS9y+A
 HeR0a02EHAfYo7gdreXvtgx4F+ZeXPk1E7Tz7fhpFRTiZycSVEQm+Hq2dENZanzsEzxu/4272
 fwty0ev1m6EGjs3pT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This change converts the existing mmap_sem rwsem calls to use the new
> mmap locking API instead.
>
> The change is generated using coccinelle with the following rules:

Do you find the following script variant more succinct together
with the usage of a disjunction in a single SmPL rule?


@replacement@
expression x;
@@
(
-init_rwsem
+mmap_init_lock
|
-down_write
+mmap_write_lock
|
-down_write_killable
+mmap_write_lock_killable
|
-down_write_trylock
+mmap_write_trylock
|
-up_write
+mmap_write_unlock
|
-downgrade_write
+mmap_downgrade_write_lock
|
-down_read
+mmap_read_lock
|
-down_read_killable
+mmap_read_lock_killable
|
-down_read_trylock
+mmap_read_trylock
|
-up_read
+mmap_read_unlock
|
-rwsem_is_locked
+mmap_is_locked
)
 (
- &
  x
- ->mmap_sem
 )


Regards,
Markus
