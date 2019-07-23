Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A86E7143B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 10:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfGWInB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 04:43:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35700 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfGWInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:43:00 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so80159265ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 01:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WZLkY1ukcSFhJ4zU4iEQRwr9NUJeO7F00THxs/TZ5ec=;
        b=BQxMhwdcK9GaFai1EMaT90mKLkNkkj6Y9bnStmmP84wAyehO+n5jjJIRB7rjKArAbc
         lfiKnHTRCPvZxSOFUgBgmdgG1ahWL35DSGvps1qG3sr/YQg9WCezkNsMLlzYKzYVKZbr
         4Zp/Yd2HPEFrKw3XQqTvMZpNbKHxsL7uymn05aXYMQdClpOBi22o/qiyvpmEyOCwEkgY
         xyN5l6+iR71nY3oHV/Au5Oc0QQ2olVHv/N2jX5Liy7BxvSvA8jyRpR5uLHJ1Hk9jyBHu
         GiIPwU36lSzbTDNrK96sEAHf7KSjoqwWzHkkK3BUAHA+5MVsz5yEGocx8sqwErZCiyAQ
         51wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WZLkY1ukcSFhJ4zU4iEQRwr9NUJeO7F00THxs/TZ5ec=;
        b=lsgR6ZDtPj++NFlprC7gcICFQMOcNSksxzrbvtk9HhuxgLXQmR2OBiDSD/uJOPPrlg
         zxXhdx1PNF/owkgXMPff1jb/RztE95Cn+Wlnlw6YlY3mBq+ffDjIqbyWtAzEC2Hzfslb
         tPy6Wat56BtEm0JOTJa5zB91eVoyHmsOevIWCCBlorgUmfF9rUmgwnV8ZQQ1f/Yxy8gI
         rpGZGT57OrT+tm3cgiwm5dSZ1xdHAp3NBomKVTA6FickJXMPfZDG6vacBASClwzyWbnL
         VFB68NC/+doArS5kF+qMc5jjrklcj0FfTHmkJl9fp+gG41zmWbXQBQlDmkIXtEWmaLzD
         HbDA==
X-Gm-Message-State: APjAAAXrnqq+M7WzfctuNk5fHJAp7f4ta3SETDcB/vDeuC0Yk6XbNYD9
        0xlF1t6ZtphpMtMzDsYm+tPWeAIl54rkTQiONQo=
X-Google-Smtp-Source: APXvYqyu+76FqPtLxmZWcT/WMQCH4thR9poXHra953Wyo6PXPkm+0/Qdh1lLrPUqXxmpYwOcJZQf+8g2KHSJI5nynqE=
X-Received: by 2002:a5e:8c11:: with SMTP id n17mr2820476ioj.64.1563871379852;
 Tue, 23 Jul 2019 01:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <2c912379f96f502080bfcc79884cdc35@fau.de> <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
 <2835dfa18922905ffabafb11fca7e1d2@fau.de>
In-Reply-To: <2835dfa18922905ffabafb11fca7e1d2@fau.de>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 23 Jul 2019 10:42:48 +0200
Message-ID: <CAKXUXMwfd133rv0bMert-BBftaqxxr_93dUHpaUjEwE8RE_wwA@mail.gmail.com>
Subject: Re: get_maintainers.pl subsystem output
To:     "Duda, Sebastian" <sebastian.duda@fau.de>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian, Hi Joe,

On Tue, Jul 23, 2019 at 9:30 AM Duda, Sebastian <sebastian.duda@fau.de> wro=
te:
>
> Hi Joe,
>
> when analyzing the patch
> `<20150128012747.824898918@linuxfoundation.org>` [1] with
> `get_maintainers.pl --subsystem --status --separator , /tmp/patch`,
> there is the following output:
>
>      Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM),Josef Bacik
> <jbacik@fb.com> (maintainer:BTRFS FILE SYSTEM),David Sterba
> <dsterba@suse.cz> (maintainer:BTRFS FILE SYSTEM),Alexander Viro
> <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and
> infrastructure)),"Theodore Ts'o" <tytso@mit.edu> (maintainer:EXT4 FILE
> SYSTEM),Andreas Dilger <adilger.kernel@dilger.ca> (maintainer:EXT4 FILE
> SYSTEM),Jaegeuk Kim <jaegeuk@kernel.org> (maintainer:F2FS FILE
> SYSTEM),Changman Lee <cm224.lee@samsung.com> (maintainer:F2FS FILE
> SYSTEM),Miklos Szeredi <miklos@szeredi.hu> (maintainer:FUSE: FILESYSTEM
> IN USERSPACE),Steven Whitehouse <swhiteho@redhat.com> (supporter:GFS2
> FILE SYSTEM),Anton Altaparmakov <anton@tuxera.com> (supporter:NTFS
> FILESYSTEM),Hugh Dickins <hughd@google.com> (maintainer:TMPFS (SHMEM
> FILESYSTEM)),linux-btrfs@vger.kernel.org (open list:BTRFS FILE
> SYSTEM),linux-kernel@vger.kernel.org (open
> list),linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
> infrastructure)),linux-ext4@vger.kernel.org (open list:EXT4 FILE
> SYSTEM),linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE
> SYSTEM),fuse-devel@lists.sourceforge.net (open list:FUSE: FILESYSTEM IN
> USERSPACE),cluster-devel@redhat.com (open list:GFS2 FILE
> SYSTEM),linux-ntfs-dev@lists.sourceforge.net (open list:NTFS
> FILESYSTEM),linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
>      Maintained,Buried alive in reporters,Supported
>      BTRFS FILE SYSTEM,THE REST,FILESYSTEMS (VFS and infrastructure),EXT4
> FILE SYSTEM,F2FS FILE SYSTEM,FUSE: FILESYSTEM IN USERSPACE,GFS2 FILE
> SYSTEM,NTFS FILESYSTEM,MEMORY MANAGEMENT,TMPFS (SHMEM FILESYSTEM)
>
> How can I parse this output automatically? or how can I generate a
> parsable output?
>
> I need the tuples of subsystems and status:
> (THE REST, Buried alive in reporters)
> (TMPFS, Maintained)
> (BTRFS FILE SYSTEM, Maintained)
> =E2=80=A6
> (GFS2 FILE SYSTEM, Supported)
>
> I'm not aware how to reliably assign the statuses to the subsystems.
>

Joe, I hope this example makes more clear what and how Sebastian would
actually like to have the information from the MAINTAINERS file
presented for our use case. Currently, we would consider
get_maintainer.pl to be the proper place for such a feature in the
upstream development.

Joe, would you support and would you accept if we extend
get_maintainer.pl to provide output of the status in such a way that
the status output can be clearly mapped to the subsystem?
If so, we would try our best to extend the current script and sent
those patches back to lkml for review and inclusion.
If you do not support to extend get_maintainer.pl as we suggest, we
would probably simply write our own specific script (probably then in
python) to parse MAINTAINERS and extract and present the information
as we need for our use case.

Sebastian, Considering style of mail interaction, please do not use top pos=
ting:
If you want to answer to a specific point of the previous mail
discussion, keep only the relevant part for your answer (delete the
rest!) and answer inline.
If you start a new discussion and do not refer to any points of the
previous discussion very specifically, just delete the whole previous
discussion and do not resend the content of previous mails.


Best regards,

Lukas
