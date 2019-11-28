Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78E10CC07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 16:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfK1Pqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 10:46:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39924 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK1Pqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:46:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so28568004wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 07:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sIubRS4qLZI1jaaKqOxxNv4bjCiQZULaHKOwIakIJiY=;
        b=Q3BQTiqX5Lg4QuiJLo2cdD0rmmi8R2EVUw9DjmYZq0c4OoYQmZiqXDkc3TK4ZuiPmZ
         DE+QgTgEtvYiNRP4izFSOXzwYahsdjzutfo8QiiNzrfagpRGguD5CE0Jq6ToFK63+Knf
         Il9sKC+ifrIbgdP1nPgkKoJlCKefiLvVJDsv+uYOof1u6uI6ZObcav/uNv4QvtKEycyr
         YIj/eHivMXHWBPT6/ToXUNJr+nBzOcRXOx5qRSTzOzzBKFgpqDF62mu9ZGQHqeGYb0RY
         869KaYmT14F3SwL4QFI2Pfcdcj64Tzjh7rBgVFf3n1V+A0hMEQd9w5nC70CGiXE3Xrlm
         2+kQ==
X-Gm-Message-State: APjAAAU6kYLtazbxOBVvVmyJwQgJHBPepBkjMjpS8UhycZrPhk13iugu
        4bvNRWT/FyChkL5J3E9adqM=
X-Google-Smtp-Source: APXvYqweU1Xq3ZlSnJcthj6s1cWlgUvpvTMSYvKjK+EzZFsvPtfmfrPAjkquxBMUXFmf8EH8boUJ5g==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr49099419wra.305.1574955999271;
        Thu, 28 Nov 2019 07:46:39 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m9sm22790884wro.66.2019.11.28.07.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:46:38 -0800 (PST)
Date:   Thu, 28 Nov 2019 16:46:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in
 find_(smallest|biggest)_section_pfn
Message-ID: <20191128154637.GO26807@dhcp22.suse.cz>
References: <c1857505-4565-99c8-d86d-efa6c076312a@redhat.com>
 <687DAE43-C40F-4527-876D-CAC750D150B6@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <687DAE43-C40F-4527-876D-CAC750D150B6@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-11-19 10:29:24, Qian Cai wrote:
> What I don’t understand is that we have an policy prohibiting code
> churn like code optimization in cold path, but allow those micro
> cleanup of code. Those cleanup also tend to be unregulated and is
> subject to personal tastes (for example, your CS teachers may have a
> different taste from mine).

I tend to push back on cleanups without a clear added value. In this
particular case it is not about aesthetic or a personal feeling about
the code though. Please read my comment with the ack.

-- 
Michal Hocko
SUSE Labs
