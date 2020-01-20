Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244CA142102
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 01:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgATAJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 19:09:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40428 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgATAJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 19:09:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itKdH-00BiuV-9B; Mon, 20 Jan 2020 00:09:31 +0000
Date:   Mon, 20 Jan 2020 00:09:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120000931.GX8904@ZenIV.linux.org.uk>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <20200119230809.GW8904@ZenIV.linux.org.uk>
 <20200119233348.es5m63kapdvyesal@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200119233348.es5m63kapdvyesal@pali>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 12:33:48AM +0100, Pali Rohár wrote:

> > Does the behaviour match how Windows handles that thing?
> 
> Linux behavior does not match Windows behavior.
> 
> On Windows is FAT32 (fastfat.sys) case insensitive and file names "č"
> and "Č" are treated as same file. Windows does not allow you to create
> both files. It says that file already exists.

So how is the mapping specified in their implementation?  That's
obviously the mapping we have to match.

> > That's the only reason to support that garbage at all...
> 
> What do you mean by garbage?

Case-insensitive anything... the only reason to have that crap at all
is that native implementations are basically forcing it as fs
image correctness issue.  It's worthless on its own merits, but
we can't do something that amounts to corrupting fs image when
we access it for write.
