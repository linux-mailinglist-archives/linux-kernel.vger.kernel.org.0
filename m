Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBA6193C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCZJ42 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Mar 2020 05:56:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZJ42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:56:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 982FBAC8F;
        Thu, 26 Mar 2020 09:56:26 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     longli@linuxonhyperv.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: Re: [PATCH] cifs: Remove locking in smb2_verify_signature() when
 calculating SMB2/SMB3 signature on receiving packets
In-Reply-To: <1585159997-115196-1-git-send-email-longli@linuxonhyperv.com>
References: <1585159997-115196-1-git-send-email-longli@linuxonhyperv.com>
Date:   Thu, 26 Mar 2020 10:56:25 +0100
Message-ID: <87d08zzbg6.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

longli@linuxonhyperv.com writes:
> On the sending and receiving paths, CIFS uses the same cypto data structures
> to calculate SMB2/SMB3 packet signatures. A lock on the receiving path is
> necessary to control shared access to crypto data structures. This lock
> degrades performance because it races with the sending path.
>
> Define separate crypto data structures for sending and receiving paths and
> remove this lock.

Something I've often wondered: why do we keep crypto state in the server
structure instead of creating it as needed in the caller stack (thus
avoiding the need for locks). AFAIK there's no state that need to be
kept between signing/encrypting calls beside the access to keys. Is it that
expensive to create/release?

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
