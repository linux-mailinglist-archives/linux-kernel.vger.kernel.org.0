Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC6192B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfEITNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 15:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbfEITNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:13:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D7AB2085A;
        Thu,  9 May 2019 19:13:32 +0000 (UTC)
Date:   Thu, 9 May 2019 15:13:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ktest: cleanup get_grub_index
Message-ID: <20190509151330.6165bb43@gandalf.local.home>
In-Reply-To: <20190509184158.te2cglg2nuvgm6gm@gabell>
References: <20190509174630.26713-1-msys.mizuma@gmail.com>
        <20190509174630.26713-3-msys.mizuma@gmail.com>
        <20190509135721.4802161b@gandalf.local.home>
        <20190509184158.te2cglg2nuvgm6gm@gabell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 14:41:59 -0400
Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> On Thu, May 09, 2019 at 01:57:21PM -0400, Steven Rostedt wrote:
> > On Thu,  9 May 2019 13:46:27 -0400
> > Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> >   
> > > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > > 
> > > Cleanup get_grub_index().  
> > 
> > Hi Masayoshi,
> > 
> > Thanks for the patches, quick comment below.
> >   
> > > 
> > > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > > ---
> > >  tools/testing/ktest/ktest.pl | 50 +++++++++++-------------------------
> > >  1 file changed, 15 insertions(+), 35 deletions(-)
> > > 
> > > diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> > > index 3862b23672f7..1255ea0d9df4 100755
> > > --- a/tools/testing/ktest/ktest.pl
> > > +++ b/tools/testing/ktest/ktest.pl
> > > @@ -1934,46 +1934,26 @@ sub get_grub2_index {
> > >  
> > >  sub get_grub_index {
> > >  
> > > -    if ($reboot_type eq "grub2") {
> > > -	get_grub2_index;
> > > -	return;
> > > -    }
> > > -
> > > -    if ($reboot_type ne "grub") {
> > > -	return;
> > > -    }  
> > 
> > We still need something like:
> > 
> > 	if ($reboot_type !~ /^grub/) {
> > 		return;
> > 	}
> > 
> > Because I believe this will run (and probably error) for syslinux boot
> > systems. I have a couple, I could test it and find out ;-)  
> 
> Thank you for your review! I'll add the check.
>


> > > -    return if (defined($grub_number) && defined($last_grub_menu) &&
> > > -	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
> > > -	       $last_machine eq $machine);
> > > -
> > > -    doprint "Find grub menu ... ";
> > > -    $grub_number = -1;
> > > +    my $command;
> > > +    my $target;
> > > +    my $skip;
> > > +    my $grub_menu_qt;
> > >  
> > > -    my $ssh_grub = $ssh_exec;
> > > -    $ssh_grub =~ s,\$SSH_COMMAND,cat /boot/grub/menu.lst,g;


> > > +    return if ($reboot_type ne "grub") and ($reboot_type ne "grub2");

I missed that you added that, which is basically the same. But I think
just doing a check of "^grub" is a bit cleaner.

Looking forward for a v2 of your patch series.

Note, I do have some travel coming up, so if you don't hear from me in
a week after you post them, please send me a ping, as my email gets
harder to maintain when I travel.

Thanks!

-- Steve

> > >  
> > > -    open(IN, "$ssh_grub |")
> > > -	or dodie "unable to get menu.lst";
> > > -
> > > -    my $found = 0;
> > > -    my $grub_menu_qt = quotemeta($grub_menu);
> > > +    $grub_menu_qt = quotemeta($grub_menu);
> > >  
> > > -    while (<IN>) {
> > > -	if (/^\s*title\s+$grub_menu_qt\s*$/) {
> > > -	    $grub_number++;
> > > -	    $found = 1;
> > > -	    last;
> > > -	} elsif (/^\s*title\s/) {
> > > -	    $grub_number++;
> > > -	}
> > > +    if ($reboot_type eq "grub") {
> > > +	$command = "cat /boot/grub/menu.lst";
> > > +	$target = '^\s*title\s+' . $grub_menu_qt . '\s*$';
> > > +	$skip = '^\s*title\s';
> > > +    } elsif ($reboot_type eq "grub2") {
> > > +	$command = "cat $grub_file";
> > > +	$target = '^menuentry.*' . $grub_menu_qt;
> > > +	$skip = '^menuentry\s|^submenu\s';
> > >      }
> > > -    close(IN);
> > >  
> > > -    dodie "Could not find '$grub_menu' in /boot/grub/menu on $machine"
> > > -	if (!$found);
> > > -    doprint "$grub_number\n";
> > > -    $last_grub_menu = $grub_menu;
> > > -    $last_machine = $machine;
> > > +    _get_grub_index($command, $target, $skip);
> > >  }
> > >  
> > >  sub wait_for_input  
> >   

