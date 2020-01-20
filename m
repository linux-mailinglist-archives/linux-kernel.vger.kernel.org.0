Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145A21428AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 12:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATLA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 06:00:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43582 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgATLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:00:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so29058122wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h0kvQ4eCX79cpNR9tBb856KH4IB2MxohzQIizX2CeOI=;
        b=B6/6xZTEr6V0++DfY1ylmdTYxdhl/GcgB1ZbHA6eMl5px5cB/qiivsacOUp74gwG5C
         gejERd4IdLUidU9rCmQL5ivW2cjrv609ZzKDtji1yVhfW2D4ZY9hVSQwlScAhDiDwBh/
         GMl3Mb090BjevPnMdSIu4rkvdfG+KM5RjLj98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h0kvQ4eCX79cpNR9tBb856KH4IB2MxohzQIizX2CeOI=;
        b=f9eQveHXIydjeCKGF7COBk1Z5jhUDJLIJGg2xyKaK+FU4lnAGcQ7h1dE5A/21Lv9A4
         2Rum7JYZD952oWTVflvOh40qYRxVi1d7IBw8P4VVBNrGgnMXKPf69muEFhZHyPKZj66u
         Zfvwbk3U89its6/Rv5maoT64iKD3E0zS4AiTAA5ACZyw0+xcXPf3mcF2uvxSe8ZSUFMq
         2tc36MaDLpRM81MiqEHJAN6nmu/YYNl7kE+3GuHwTUA5BKDFQfTwldFs8EPrkogvz+bv
         WqzwNF7i7LoD+g25dpvroxaUlExsjQ8ie/e+P7SG5Bb94IXcYrAYeoq/msnLBnx3XUZO
         bKHA==
X-Gm-Message-State: APjAAAU78lYIo/fm9YzTf8K8wscqI/6cOLLGCa4ovegDRx4YeTb4ZkE3
        gG9CSC6xst/3tC5w/Q3vbRGeDA==
X-Google-Smtp-Source: APXvYqxMSc51FxkyiwRzhynXKNNeeQtMip5aCjqZxIyrjKMZGMDBa8eIDMoS5v8dmDLw25owEHo1Zg==
X-Received: by 2002:adf:f484:: with SMTP id l4mr18387323wro.207.1579518024273;
        Mon, 20 Jan 2020 03:00:24 -0800 (PST)
Received: from chromium.org ([2620:0:105f:fd00:24a7:c82b:86d8:5ae9])
        by smtp.gmail.com with ESMTPSA id h66sm25546490wme.41.2020.01.20.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:00:23 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 20 Jan 2020 12:00:44 +0100
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 01/10] bpf: btf: Make some of the API visible
 outside BTF
Message-ID: <20200120110044.GA26394@chromium.org>
References: <20200115171333.28811-2-kpsingh@chromium.org>
 <202001182045.QaQ0kGP8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202001182045.QaQ0kGP8%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! I have fixed this in the v3 of the series. btf_find_by_name_kind
is independant of CONFIG_BPF_SYSCALL and btf_type_by_name_kind needs
to be as well.

The mistake was adding a static inline definition of the function
in the !CONFIG_BPF_SYSCALL section which is not needed in this case.

- KP

On 18-Jan 20:44, kbuild test robot wrote:
> Hi KP,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20200116]
> [cannot apply to bpf-next/master bpf/master linus/master security/next-testing v5.5-rc6 v5.5-rc5 v5.5-rc4 v5.5-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/KP-Singh/MAC-and-Audit-policy-using-eBPF-KRSI/20200117-070342
> base:    2747d5fdab78f43210256cd52fb2718e0b3cce74
> config: nds32-defconfig (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=nds32 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/bpf/core.c:27:
> >> include/linux/btf.h:148:38: error: static declaration of 'btf_type_by_name_kind' follows non-static declaration
>      148 | static inline const struct btf_type *btf_type_by_name_kind(
>          |                                      ^~~~~~~~~~~~~~~~~~~~~
>    include/linux/btf.h:70:24: note: previous declaration of 'btf_type_by_name_kind' was here
>       70 | const struct btf_type *btf_type_by_name_kind(
>          |                        ^~~~~~~~~~~~~~~~~~~~~
> 
> vim +/btf_type_by_name_kind +148 include/linux/btf.h
> 
>    136	
>    137	#ifdef CONFIG_BPF_SYSCALL
>    138	const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
>    139	const char *btf_name_by_offset(const struct btf *btf, u32 offset);
>    140	struct btf *btf_parse_vmlinux(void);
>    141	struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
>    142	#else
>    143	static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
>    144							    u32 type_id)
>    145	{
>    146		return NULL;
>    147	}
>  > 148	static inline const struct btf_type *btf_type_by_name_kind(
>    149		struct btf *btf, const char *name, u8 kind)
>    150	{
>    151		return ERR_PTR(-EOPNOTSUPP);
>    152	}
>    153	static inline const char *btf_name_by_offset(const struct btf *btf,
>    154						     u32 offset)
>    155	{
>    156		return NULL;
>    157	}
>    158	#endif
>    159	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


