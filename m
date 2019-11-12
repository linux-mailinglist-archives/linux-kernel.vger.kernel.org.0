Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF64F9DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 00:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKLXNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 18:13:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43529 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLXNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:13:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id y23so315003ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ij9cU3rzSNwe6IMkfMROpz0oxgYd0m7kzKqASM4qZ7U=;
        b=DtAw5Py86LlSHnBNX924EIO2myy2vtJoK3nvel3zsBct8EwNvuxdPT1w0f9osz9Qrf
         aIJv4WhWxkQEiUyM15vAAkE20vzOMZutJ7k4kYq5Z8TS3WFJxPAqeaPh8v7NE3WTHxsA
         2Zm4UcyyU5KtXn1kaL5zoJE/c4C81Ph3eFAgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ij9cU3rzSNwe6IMkfMROpz0oxgYd0m7kzKqASM4qZ7U=;
        b=ejxbiY7QNUaU1Xt1HTnHtZpFIL6TFB5DvrueBdIjJvDz+06f07xcb3zlUjpvx/of9Y
         0DBi7AOrawbT9GkIMYBd4OYxOjD3aFnxtGXP/x+kuJZlvtAmtv0BMZW3NsADK8OXrRkQ
         2CIkHAbr2BuYhW7aPrS6ZAJw5i4em6EFlo9oFUI8b6+EO2AxzZJR7mfmBueOBpQDXaO7
         p3nHd0M4Mh5XKsAmyPl4ikFgJIh9tjmmfPMlG5cTzfbLorVnt1p4OYb2QNGxlaLhal0G
         6Ccw5rDXw1vTQnAzJV0j1T4WTqLb3fCEJKSf5I38VHazZ8enz0z8ynjJmhu3VSHSjDdD
         5tvQ==
X-Gm-Message-State: APjAAAVFJp2quwAqEI8uIGWq/dTQoZ+9jpHHHcT3pn3jWLbKJrTI119o
        I+Ki9CVSWFYYloO6h/7SjxhCJ/7ewQg=
X-Google-Smtp-Source: APXvYqy+oQzE7wokvZivlXPCWdzzgHm4H9s8VYAGcPtgmLZ+At0mHLuH6RCTem0W+Q0d4vk1TB3gnA==
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr199487ljs.26.1573600391262;
        Tue, 12 Nov 2019 15:13:11 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id w18sm61716lji.38.2019.11.12.15.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 15:13:10 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id d22so325838lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:13:10 -0800 (PST)
X-Received: by 2002:a2e:982:: with SMTP id 124mr206060ljj.48.1573600389824;
 Tue, 12 Nov 2019 15:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20191110154303.GA2867499@kroah.com> <20191112063440.GA15951@infradead.org>
 <20191112065629.GA1242198@kroah.com> <20191112225427.GA1873491@kroah.com>
In-Reply-To: <20191112225427.GA1873491@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 15:12:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLZpyGyOcymND-Pk7_a_MXHZHJtsT9TryHmZBE7Babiw@mail.gmail.com>
Message-ID: <CAHk-=wiLZpyGyOcymND-Pk7_a_MXHZHJtsT9TryHmZBE7Babiw@mail.gmail.com>
Subject: Re: [PATCH] vboxsf: move out of staging to fs/
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 2:54 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Christoph, this is what you mean, right?  If so, I'll send this to Linus
> later this week, or he can grab it right from this patch :)

No.

I was unhappy about a staging driver being added in rc7, but I went
"whatever, it's Greg's garbage"

There is no way in hell I will take a new filesystem in rc8.

Would you take that into stable? No, you wouldn't. Then why is this
being upstreamed now.

Honestly, I think I'll just delete the whole thing, since it shouldn't
have gone in in the first place. This is not how we add new
filesystems.

             Linus
