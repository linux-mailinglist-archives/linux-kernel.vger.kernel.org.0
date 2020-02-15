Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE315FD1D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 07:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgBOG3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 01:29:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56508 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgBOG3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 01:29:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2qxG-00D47H-OY; Sat, 15 Feb 2020 06:29:30 +0000
Date:   Sat, 15 Feb 2020 06:29:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Atul Gupta <atul.gupta@chelsio.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] almost certain bug in
 drivers/crypto/chelsio/chcr_algo.c:create_authenc_wr()
Message-ID: <20200215062930.GA23230@ZenIV.linux.org.uk>
References: <20200215061416.GZ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215061416.GZ23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Another fairly bug in there (this time in
drivers/crypto/chelsio/chtls/chtls_io.c):

/* Read TLS header to find content type and data length */
static int tls_header_read(struct tls_hdr *thdr, struct iov_iter *from)  
{
        if (copy_from_iter(thdr, sizeof(*thdr), from) != sizeof(*thdr))
                return -EFAULT;
        return (__force int)cpu_to_be16(thdr->length);
}

For one thing, that kind of force-casts is pretty much always wrong.
This one clearly says "should've used be16_to_cpu()".  And that includes
annotating tls_hdr ->length as __be16; no idea about the other field
in there (->version, that is).

For another, the only caller is
                        recordsz = tls_header_read(&hdr, &msg->msg_iter);
                        size -= TLS_HEADER_LENGTH;
                        copied += TLS_HEADER_LENGTH;
                        csk->tlshws.txleft = recordsz;
                        csk->tlshws.type = hdr.type;
                        if (skb)
                                ULP_SKB_CB(skb)->ulp.tls.type = hdr.type;
which doesn't look like something that'll work if you get -EFAULT out of
that function.  If anything, that smells like we want
                        recordsz = tls_header_read(&hdr, &msg->msg_iter);
			if (recordsz < 0)
				goto do_fault;
			...

What's more, we do *not* want a header that has faulted halfway through
to be consumed.  IOW, we want copy_from_iter_full():

static int tls_header_read(struct tls_hdr *thdr, struct iov_iter *from)  
{
        if (!copy_from_iter_full(thdr, sizeof(*thdr), from))
                return -EFAULT;
        return be16_to_cpu(thdr->length);
}

in addition to that missing check in the caller...
