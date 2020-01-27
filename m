Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5B114A3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 13:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgA0M3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 07:29:07 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38808 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbgA0M3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:29:07 -0500
Received: by mail-pj1-f68.google.com with SMTP id m4so3051591pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 04:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1R6WgPaLfjprnwT2K/UdFzkWhfqg+Wgh1Aa2jhCg0M=;
        b=kyngqvLLf3+MJMnVXsCplq5vDbb0JfZH1dTrEG0ryUa7zh+3I64JbYu9R3L1CxVb/a
         Xo6urOcr8ADLoISKgDXoGJSd/zkVFTiRv174duzJgZPi8UOfUvkGdgcHMT08TCrGH3AA
         Hr0pSULJWzoHk0pkXOUQiq7JrmKOGqqsQTxMU37WobJ9OPtBtemdL585dgUDsC7GBMdR
         iKHXbSk+Qdks7U32g84daLQ5o2ekHG4kOPnoUeWM3kTy6S8SUxJhMtQDpx1AKg2IeDHP
         o248tw9F0wR/82oFB1vZqwc6+srMdD/0TxOOVQlgJtC3CvYA32rel3tI/xG4O8LUvUJY
         FvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1R6WgPaLfjprnwT2K/UdFzkWhfqg+Wgh1Aa2jhCg0M=;
        b=b4N18ah9IYV78uxr+VEJJz4ZMUwMRqDsx8YhRd55UiDBPraxbNX4LuUZhM8pbxuG1t
         vGho28j/RWBGOe6ZZGnpGuIOdGzCaR5B+vg7DpY2aUM65E/RDMILXXSndeyb3w5gWwjz
         DnRdrTs5oaPfdyNE9v12VujwAOBJ/W+YolMdEOHRCnmMjN6WtMf8QJJKBhcOfWGj7fbs
         bteY9sJdA6W1/I6DcLBsdcxD1P3Obnt8ksR6jH0tqydpCWC6v9BhxRx5zEeAYFhfWhfY
         B49HPCamW+QtQhlgWw8sRSeaU2ISUFCEU2u6aEhVPTMfr/lmPuXc0J0mqaFY5HAz31tT
         fBXw==
X-Gm-Message-State: APjAAAX3kVMo7BuWFttWDOCcWFMiiPUv98XuAInMfVRyrSyOxXur66Xy
        5OHmhbvyZgFaLngMpaztbxdL9Q2/aAaj7PuwYliQuQ==
X-Google-Smtp-Source: APXvYqwbkq6UEFBP55j3Hu+JAlu5Cyx+6MQ4jxtADqpUnjtOkwWS78sgZ2BBaiYS2fpkGLv6HL6e7mZyBq8tqwh4L+8=
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr18100629plt.147.1580128146719;
 Mon, 27 Jan 2020 04:29:06 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004dbaf2059c193a36@google.com> <20200126024957.11392-1-hdanton@sina.com>
 <20200127092850.GX1847@kadam>
In-Reply-To: <20200127092850.GX1847@kadam>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 27 Jan 2020 13:28:55 +0100
Message-ID: <CAAeHK+wddN62F0JAVfma8aUHy4FtkfSViSQuXB1ESNjQXLSD0Q@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in hiddev_disconnect
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+106b378813251e52fc5e@syzkaller.appspotmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 10:29 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> I already fixed this bug in an earlier thread.
>
> Syzbot always reports a use after free as two separate bugs, a read
> after free and a write after free.  It's too much hassle to mark all
> the duplicates.
>
> regards,
> dan carpenter
>
>

#syz dup: KASAN: use-after-free Write in hiddev_disconnect
