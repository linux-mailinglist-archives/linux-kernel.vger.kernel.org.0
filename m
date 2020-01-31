Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19F314E65C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgAaAKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 19:10:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35612 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgAaAKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:10:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so6591102wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 16:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGmOfWdXKTAe9ibSYM5ANd6MBFVxWU+wRY8gMllVMzQ=;
        b=lGweN0ZWB8Hvtqex/qm6X1ItL2L/Qvyj8lem4bEXEOlsCEa9kVEcgXmdewfd9r+G0M
         AhwBQzrplKgwqzDwj7qAA40txJqm5ySeTBgEq3XGxwG2EYcr7vU72LkRiwuO26r2SQ09
         3qIKCEzVh0LpnUHou68iR8FGrq44uLeVOZYZ6Cri8xNGEXUfU81sIRqrBwWYkg+UiRWA
         PhZeoLW3RnVOPgPDygUbDjchIUsIv1DG+NsJXh80AmO8DGzWShgpmns+MqZv2rlrhKFo
         6OAXWGzGGMPWdhXr+FursVSUfTTgcJAWWXxTRFZi/uV925eRL5x6l8s4rVTfvOYduP+R
         bDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGmOfWdXKTAe9ibSYM5ANd6MBFVxWU+wRY8gMllVMzQ=;
        b=k9lgHx8SF9CG01z9n9lMbhg8eTvhWEnSiK2ycHvW8s7NfLs7Gf1GIJUnhJEX+3rlPl
         ZylopzHpOowv5Jlcr3YmXLFsvy78bqRtR5fu8y1SYMFItqOxD1hnQZkYE7hNGmikKvmO
         1J2fS/8DJmmk4Z0IP3umXOFaKsaKF1R/TAlq2jdNBdKQc+9qD9e2VTYjWGRO3e3q1n55
         sNHCmhDiZPffmq34mzcITmiq9KDKXSiaZcgXM2PRj4tU3QkOtbyCUsQrns2iTCPstlIm
         h0GBcKcXXFqFE25cJ6UfM3zmJMvTkziHskVIdU1tQVdF9DIMqVi2WVYq7NVuhYEUxisn
         zTPA==
X-Gm-Message-State: APjAAAWH+83cEYnzsFHQiZxh5EZflDyWZERa2sQbCXyLoNPYA0zlVqS5
        3M0+EYVuTvC0gtyciUm5SUwmgutJPxzyzoHD9Q0sGg==
X-Google-Smtp-Source: APXvYqxth3izrY8iTpVM4mOb6kQ0E8ue8yQcZfAMAR7Llkyr0KHPrh0u8aQjBp+FtmXrSaW0UphTJJSbsxKt345wXRs=
X-Received: by 2002:a05:600c:21c5:: with SMTP id x5mr8430126wmj.72.1580429415652;
 Thu, 30 Jan 2020 16:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20200130121205.40cbb903@gandalf.local.home> <20200130121352.466e3300@gandalf.local.home>
In-Reply-To: <20200130121352.466e3300@gandalf.local.home>
From:   Shuah Khan <shuahkhan@gmail.com>
Date:   Thu, 30 Jan 2020 17:10:04 -0700
Message-ID: <CAKocOOOnFTa3-FTBFSnbaLdQbXZiH4gx4=ZyoU0pW_pQv40efg@mail.gmail.com>
Subject: Re: [PATCH] selftests/ftrace: Have pid filter test use instance flag
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 10:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> Shuah,
>
> Can you take this through your tree?
>

Yes. I can take this. Could you please resend it to the addresses
listed by get_maintainers.pl
shuah@kernel.org or skhan@linuxfoundation.org and cc linux-kselftest
mailing list

thanks,
-- Shuah
