Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E386B168F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfEGRRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 13:17:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33529 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfEGRRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:17:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so2652895pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sXiQJbpi/4IGaaTOVq7540dm+WX0y+kDeTKOVgV+NMk=;
        b=OrB1lgi2e5zENC5xyWyvWQlBbafJaPk/dhSP7eqEOwgN+g5epKpCynLaNInuOffPJW
         Y7KfBhVuc8GkA09O1V0m+yT89l3VxpB/ZlVa9qyXaEuMndK09H1aFyf4VlsFjogHEAuA
         EoV8tJOUg8v067Z5ptBuIe5cHUyjWDL3LjqH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXiQJbpi/4IGaaTOVq7540dm+WX0y+kDeTKOVgV+NMk=;
        b=aYP0SXfW9V+6TT43BvsUy9JUkWeVilcxuIVftg/dYgAjjSorEBSUOjGz0uPjTJunkM
         NHfjPlLy7n8tDLot0XVborSXOUUL7Z7h4hEIi9QUrHDQWEKp/UASh4Da5DhLs7m19Ben
         JDq4uQ2FWfChfYHOyy2Obs2bR9oCLlubZuSDw2lmO048YnE2yThqQmxR9AY8720crSUT
         J3YwSp81hTw+B86dwEP5TwQEkEiiR4wlR0qRscLfcS23iSiC9PyUaoNzBO328eDS8H4s
         SBdXx1zUFqup7elpHyewxlZ+71IJ0eh3yK/TLRkAzKbmDxhP+CeC2dzIU2gYpDWQYtmC
         RTVA==
X-Gm-Message-State: APjAAAXGnI7zc/s2Pvq+zIyiqtSWPPddnNeXXoOR80vPkx/JqkfPlkrN
        a7hwmWZZfAf/E/IvQZ8dkUYsJA==
X-Google-Smtp-Source: APXvYqznkP0ThPErDNtnYUHloyF7dhrTadAsD2R/2MqVYWQNALgwqZGdhqOdOSCT6tsWXaWn7VHKDw==
X-Received: by 2002:a63:1701:: with SMTP id x1mr40730723pgl.153.1557249460626;
        Tue, 07 May 2019 10:17:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s19sm16914559pfe.74.2019.05.07.10.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:17:39 -0700 (PDT)
Date:   Tue, 7 May 2019 13:17:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: Re: [PATCH v2] kheaders: Move from proc to sysfs
Message-ID: <20190507171737.GA97358@google.com>
References: <20190504121213.183203-1-joel@joelfernandes.org>
 <20190504122158.GA23535@kroah.com>
 <20190504123650.GA229151@google.com>
 <20190505091030.GA25646@kroah.com>
 <20190505132623.GA3076@localhost>
 <20190505163145.45f77e44@oasis.local.home>
 <20190507163824.GC89248@google.com>
 <20190507165718.GA1241@kroah.com>
 <20190507130333.58c95268@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507130333.58c95268@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 01:03:33PM -0400, Steven Rostedt wrote:
> On Tue, 7 May 2019 18:57:18 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > Thanks makes sense. So Greg, I submitted this properly, does it look good to
> > > you now? Steven, I would appreciate any Acks/Reviews on the patch as well:
> > > https://lore.kernel.org/patchwork/patch/1070199/  
> > 
> > Looks good to me, should get to it in a few days...
> 
> Me too. Feel free to add
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> But as for reviewing, I see nothing wrong with it, but I doubt I'll
> find something that Greg missed in this code.

Thanks!

 - Joel

