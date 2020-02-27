Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65A017291D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 21:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgB0UA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 15:00:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39024 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgB0UA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:00:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id n30so337974lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQC5XL/giSLKULG9Wvy81a1UMPlWPAivXJ99IMsyzPk=;
        b=HtiHDXlG0JR18/QlUwHqgHaaMmRjCfGt3buf0uUSKYgBFfx+4J7TF6G+NySGsdnlaH
         B4rOhvT6Ogi7oPnQxzuHB2lE5g+WnqVnP0+hnLDPqz7duPDZnUrbbdNewWrp/tgU8Cat
         LnVR7BaEsyOiMmriMtKa0e+wMcEpK3a2vIhlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQC5XL/giSLKULG9Wvy81a1UMPlWPAivXJ99IMsyzPk=;
        b=PURcCXUASgpZlgfc37IPcUe9k/KqUp8frkjLWDCvBv8thn3OTkc1Uk2bPmJkO3mHLr
         P3AuVncaw9iBF5iKf2VMIdrL6S7ZSDQ/1PiMTiDDNjzWWl6c8RWsRA3Mk/kicIFEquLq
         e4g3VBx3EGp4JGZXd14mOWCESbsExDW+s7OFw2QumvxLr7C0apEciOeWVd7R4+1XXP7A
         xXVVQESsVhld+cOVE4NgDVL65H3Ow6zkzpJjooz8w15qmuEQBU7fqGmi7CKQ2uVy/HVp
         yw4LB5g+b+JxbWrO3x0AVtI1cSCdl8nM5MRiXbgi0CmjoQKcLGBamoPyKei55oL+5ciq
         FpXQ==
X-Gm-Message-State: ANhLgQ03k3iv4NpJI0EOFuzR0WNgafGUptH7ia9XY7xWWoedyuXyWNHD
        +/XSEulVZcioVuQR7yoqvhGt17xJSWE=
X-Google-Smtp-Source: ADFU+vsWdN7xVNGRomzy8BSzp/nTS5EU8vlTtaiu2/AWi5Kishzy/AuHdbWlqmbOyB3lQbp3Hxml3A==
X-Received: by 2002:ac2:52a2:: with SMTP id r2mr542174lfm.33.1582833654685;
        Thu, 27 Feb 2020 12:00:54 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t1sm3871358lji.98.2020.02.27.12.00.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 12:00:53 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id z9so355317lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 12:00:53 -0800 (PST)
X-Received: by 2002:a19:c106:: with SMTP id r6mr603675lff.10.1582833653416;
 Thu, 27 Feb 2020 12:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-2-viro@ZenIV.linux.org.uk> <CAHk-=wjE0ey=qg2-5+OHg4kVub4x3XLnatcZj5KfU03dd8kZ0A@mail.gmail.com>
 <20200227194312.GD23230@ZenIV.linux.org.uk>
In-Reply-To: <20200227194312.GD23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Feb 2020 12:00:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wje=1xYx0N6ERSZfR8TgjSOY_PA2DSCGbE40GNwOeeF4w@mail.gmail.com>
Message-ID: <CAHk-=wje=1xYx0N6ERSZfR8TgjSOY_PA2DSCGbE40GNwOeeF4w@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 02/34] fix automount/automount race properly
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 11:43 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  A bit of reordering in the beginning eliminates discard1, suggesting
> s/discard2/discard_locked/...  Incremental would be

Ack, thanks.

          Linus
