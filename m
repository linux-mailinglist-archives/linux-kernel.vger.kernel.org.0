Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A729419A0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 23:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbgCaVlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 17:41:18 -0400
Received: from mail-a09.ithnet.com ([217.64.83.104]:51457 "EHLO
        mail-a09.ithnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaVlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:41:18 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 17:41:16 EDT
Received: (qmail 22882 invoked by uid 0); 31 Mar 2020 21:34:35 -0000
Received: from skraw.ml@ithnet.com by mail-a09 
 (Processed in 2.231369 secs); 31 Mar 2020 21:34:35 -0000
X-Spam-Status: No, hits=-1.2 required=5.0
X-Virus-Status: No
X-ExecutableContent: No
Received: from dialin014-sr.ithnet.com (HELO ithnet.com) (217.64.64.14)
  by mail-a09.ithnet.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 31 Mar 2020 21:34:32 -0000
X-Sender-Authentication: SMTP AUTH verified <skraw.ml@ithnet.com>
Date:   Tue, 31 Mar 2020 23:34:32 +0200
From:   Stephan von Krawczynski <skraw.ml@ithnet.com>
To:     linux-kernel@vger.kernel.org
Subject: Path length and filename length linux deficiency
Message-ID: <20200331233432.372f2f68@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

today I want to raise a topic that seems to have vanished completely since
decades. It's the length limits of pathnames and filenames. One may wonder why
to jump onto such a seemingly dead horse. But in fact it is not. We are in a
world of continous growth of file services for clouds and other user space
apps. And in this world a friend of mine tried to do something very simple:
copying a file tree  ...  from a w*ndows file service to a linux server. And
guess what: it does not work out.
And the simple reason: the maximum path length in w*ndows systems is 32767,
whereas linux (and POSIX) talk of a maximum of 4096 bytes. It is obvious then
that linux is effectivly unable to hold a deep tree - whereas w*ndows can.
Since I do know for sure it does not work, what are the true reasons?
How can we completely drop these limits in linux (using a capable fs of
course)?
I already asked the samba list and was confirmed that the problem is known and
that there is no easy solution for it.
-- 
Regards,
Stephan

